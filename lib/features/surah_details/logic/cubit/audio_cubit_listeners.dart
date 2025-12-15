import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_base.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_playback.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_ready.dart';
import 'package:just_audio/just_audio.dart';

mixin AudioCubitListeners on AudioCubitBase implements AudioCubitReady {
  void setupListeners() {
    int c = 0;
    posSub = player.positionStream.listen((pos) {
      if (isClosed || !ready) return;
      if (state is Success) {
        emit((state as Success).copyWith(position: pos));
        if (++c >= 5) {
          c = 0;
          AudioCubitPlayback.saveState(handler, player);
        }
      } else if (player.playing) {
        emitOk(pos);
      }
    });
    stateSub = player.playerStateStream.listen((s) {
      if (isClosed) return;
      if (!ready && (s.processingState == ProcessingState.ready || s.playing)) {
        checkReady();
      }
      if (ready && state is Success) {
        emit(
          (state as Success).copyWith(
            isPlaying: player.playing,
            total: player.duration ?? Duration.zero,
          ),
        );
      }
    });
    player.durationStream.listen((d) {
      if (ready && d != null && state is Success && !isClosed) {
        emit((state as Success).copyWith(total: d));
      }
    });
  }
}
