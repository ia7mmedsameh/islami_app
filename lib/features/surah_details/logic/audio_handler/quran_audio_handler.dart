import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

class QuranAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _sub;

  QuranAudioHandler() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _sub = _player.playerStateStream.listen((state) {
      playbackState.add(
        PlaybackState(
          controls: [
            state.playing ? MediaControl.pause : MediaControl.play,
            MediaControl.stop,
          ],
          playing: state.playing,
          processingState: _map(state.processingState),
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

  Future<void> playQuran({
    required String url,
    required String surahName,
    required int surahNumber,
  }) async {
    await _player.stop();

    mediaItem.add(
      MediaItem(
        id: url,
        title: surahName,
        artist: "تلاوة القرآن الكريم",
        album: "سورة رقم $surahNumber",
        playable: true,
      ),
    );

    await _player.play();
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
