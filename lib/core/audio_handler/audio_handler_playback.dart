import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

void broadcastState(
  PlayerState state,
  bool isLiveStream,
  int? currentSurahNumber,
  AudioPlayer player,
  BehaviorSubject<PlaybackState> playbackState,
) {
  final controls = <MediaControl>[];
  if (!isLiveStream && currentSurahNumber != null && currentSurahNumber < 114) {
    controls.add(MediaControl.skipToNext);
  }
  controls.add(state.playing ? MediaControl.pause : MediaControl.play);
  if (!isLiveStream && currentSurahNumber != null && currentSurahNumber > 1) {
    controls.add(MediaControl.skipToPrevious);
  }

  final compactIndices = <int>[];
  for (int i = 0; i < controls.length && i < 3; i++) {
    compactIndices.add(i);
  }

  playbackState.add(
    PlaybackState(
      controls: controls,
      androidCompactActionIndices: compactIndices,
      playing: state.playing,
      processingState: _mapState(state.processingState),
      updatePosition: isLiveStream ? Duration.zero : player.position,
      bufferedPosition: isLiveStream ? Duration.zero : player.bufferedPosition,
      systemActions: isLiveStream ? {} : {MediaAction.seek},
    ),
  );
}

AudioProcessingState _mapState(ProcessingState s) {
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
