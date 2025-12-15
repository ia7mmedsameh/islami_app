import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_base.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_playback.dart';
import 'package:just_audio/just_audio.dart';

mixin AudioCubitControls on AudioCubitBase {
  void pause() {
    if (!isClosed) {
      player.pause();
      AudioCubitPlayback.saveState(handler, player);
    }
  }

  void resume() {
    if (isClosed) return;
    if (player.processingState == ProcessingState.idle &&
        handler.currentSurahNumber == null) {
      onResumeIdle();
    } else {
      player.play();
    }
  }

  void onResumeIdle();

  void seek(Duration d) {
    if (!isClosed) {
      player.seek(d);
      AudioCubitPlayback.saveState(handler, player);
    }
  }

  void setVolume(double v) {
    if (isClosed) return;
    player.setVolume(v);
    if (state is Success) emit((state as Success).copyWith(volume: v));
  }

  void cycleRepeatMode() {
    handler.cycleRepeatMode();
    if (state is Success) emit((state as Success).copyWith());
  }

  Future<void> playNext({Function(int)? onNavigate}) async {
    final c = handler.currentSurahNumber;
    if (c != null && c < 114) {
      onNavigate != null ? onNavigate(c + 1) : await handler.playNext();
    }
  }

  Future<void> playPrevious({Function(int)? onNavigate}) async {
    final c = handler.currentSurahNumber;
    if (c != null && c > 1) {
      onNavigate != null ? onNavigate(c - 1) : await handler.playPrevious();
    }
  }
}
