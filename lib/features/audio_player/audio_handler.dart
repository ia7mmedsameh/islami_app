import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class IslamiAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  IslamiAudioHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      final oldMediaItem = mediaItem.value;
      if (oldMediaItem != null && duration != null) {
        mediaItem.add(oldMediaItem.copyWith(duration: duration));
      }
    });
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      playbackState.add(playbackState.value.copyWith(
        controls: [
          isPlaying ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
        ],
        
        systemActions: const {
          MediaAction.seek,
        },
        
        androidCompactActionIndices: const [0], 
        
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.buffering,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[processingState] ?? AudioProcessingState.idle,
        
        playing: isPlaying,
        bufferedPosition: _player.bufferedPosition,
        updatePosition: _player.position,
      ));
    });
  }

  Future<void> playSurah(String url, String title) async {
    await _player.stop();
    
    mediaItem.add(
      MediaItem(
        id: url,
        title: title,
        artist: 'القرآن الكريم',
      ),
    );

    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    
    await _player.play();
  }

  @override
  Future<void> play() async {
    if (_player.processingState == ProcessingState.completed) {
      await _player.seek(Duration.zero);
    }
    return _player.play();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await _player.dispose();
    return super.stop(); 
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  Future<void> stopPlayer() async {
    await _player.stop();
    mediaItem.add(null); 
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.idle,
      playing: false,
    ));
  }
}