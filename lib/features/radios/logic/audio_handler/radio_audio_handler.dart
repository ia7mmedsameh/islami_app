import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

class RadioAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _sub;

  RadioAudioHandler() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _sub = _player.playerStateStream.listen((state) {
      final playing = state.playing;
      final processing = state.processingState;

      playbackState.add(
        PlaybackState(
          controls: [
            playing ? MediaControl.pause : MediaControl.play,
            MediaControl.stop,
          ],
          playing: playing,
          processingState: _map(processing),
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
        ),
      );
    });
  }

  AudioProcessingState _map(ProcessingState s) {
    switch (s) {
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        return AudioProcessingState.idle;
    }
  }

  Future<void> playRadio(String url, String name) async {
    await _player.stop();

    mediaItem.add(
      MediaItem(
        id: url,
        title: name,
        artist: "راديو القرآن الكريم",
        playable: true,
      ),
    );

    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> setQuranMedia({
    required String url,
    required String surahName,
    required int surahNumber,
  }) async {
    mediaItem.add(
      MediaItem(
        id: url,
        title: surahName,
        artist: "تلاوة القرآن الكريم",
        album: "سورة رقم $surahNumber",
        playable: true,
      ),
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    mediaItem.add(null);
  }

  Future<void> setVolume(double v) => _player.setVolume(v);

  AudioPlayer get player => _player;
}
