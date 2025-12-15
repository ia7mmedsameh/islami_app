import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_base.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_listeners.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_controls.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_ready.dart';
import 'package:islami_app/features/surah_details/ui/helper/audio_constants.dart';
import 'package:just_audio/just_audio.dart';

export 'package:islami_app/core/audio_handler/audio_handler.dart'
    show RepeatMode;

class AudioCubit extends AudioCubitBase
    with AudioCubitReady, AudioCubitListeners, AudioCubitControls {
  AudioCubit(super.handler);

  Future<void> setAudioSource(
    int n,
    String name, {
    bool autoPlay = true,
  }) async {
    emit(const AudioState.loading());
    ready = false;
    try {
      await posSub?.cancel();
      await stateSub?.cancel();
      if (player.playing) await player.stop();
      getIt<GlobalAudioManager>().playQuran(surahNumber: n, surahName: name);
      setupListeners();
      await handler.setQuranMedia(
        url: AudioConstants.getSurahUrl(
          surahNumber: n,
          edition: AudioConstants.defaultEdition,
        ),
        surahName: name,
        surahNumber: n,
        autoPlay: autoPlay,
      );
      await waitForReady();
    } catch (_) {
      if (!isClosed) emit(const AudioState.error("حدث خطأ"));
    }
  }

  @override
  void onResumeIdle() => setAudioSource(1, '');

  void connectToExistingPlayer() {
    ready = false;
    posSub?.cancel();
    stateSub?.cancel();
    setupListeners();
    if (player.processingState == ProcessingState.ready || player.playing) {
      ready = true;
      emitOk(player.position);
    } else {
      emit(const AudioState.loading());
    }
  }
}
