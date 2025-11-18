import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:islami_app/main.dart';
import 'package:just_audio/just_audio.dart';

class RadioAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player;
  bool _isLiveStream = false;

  RadioAudioHandler(this._player) {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _player.playerStateStream.listen(_broadcast);
    _player.positionStream.listen((_) {
      if (!_isLiveStream) _broadcast(_player.playerState);
    });

    
  }

  void _broadcast(PlayerState state) {
    playbackState.add(PlaybackState(
      controls: [state.playing ? MediaControl.pause : MediaControl.play, MediaControl.stop],
      androidCompactActionIndices: const [0, 1],
      playing: state.playing,
      processingState: _map(state.processingState),
      updatePosition: _isLiveStream ? Duration.zero : _player.position,
      bufferedPosition: _isLiveStream ? Duration.zero : _player.bufferedPosition,
      systemActions: _isLiveStream ? {} : {MediaAction.seek},
    ));
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
    _isLiveStream = true;
    await _player.stop();
    mediaItem.add(MediaItem(id: url, title: name, artist: "راديو", playable: true));
    _player.setUrl(url).catchError((_) => null);
    _player.play().catchError((_) => null);
    _player.playerStateStream.firstWhere((s) => s.processingState == ProcessingState.ready).then((_) {
      playbackState.add(playbackState.value.copyWith(processingState: AudioProcessingState.ready, playing: true));
    });
  }

  Future<void> setQuranMedia({
    required String url,
    required String surahName,
    required int surahNumber,
  }) async {
    _isLiveStream = false;
    await _player.setUrl(url);
    mediaItem.add(MediaItem(
      id: url,
      title: surahName,
      artist: "تلاوة القرآن الكريم",
      album: "سورة رقم $surahNumber",
      duration: _player.duration,
      playable: true,
    ));
    await _player.play();
    audioHandler?.playbackState.add(
  PlaybackState(
    controls: [MediaControl.pause, MediaControl.stop],
    playing: true,
    processingState: AudioProcessingState.ready,
    updatePosition: Duration.zero,
    bufferedPosition: Duration.zero,
  ),
);
    try {
      await _player.playerStateStream
          .timeout(const Duration(seconds: 2))
          .firstWhere((state) => state.processingState == ProcessingState.ready || state.playing);
      _broadcast(_player.playerState);
    } catch (_) {
      for (int i = 0; i < 30; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (_player.processingState == ProcessingState.ready || _player.playing) {
          _broadcast(_player.playerState);
          break;
        }
      }
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    mediaItem.add(null);
    await super.stop();
  }

  Future<void> setVolume(double v) => _player.setVolume(v);

  AudioPlayer get player => _player;
}

