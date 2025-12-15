import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_base.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_playback.dart';
import 'package:just_audio/just_audio.dart';

mixin AudioCubitReady on AudioCubitBase {
  Future<void> waitForReady() async {
    if (ready) return;
    try {
      await player.playerStateStream
          .timeout(const Duration(seconds: 2))
          .firstWhere(
            (s) => s.processingState == ProcessingState.ready || s.playing,
          );
      checkReady();
    } catch (_) {
      for (int i = 0; i < 20; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (isClosed || ready || checkReady()) break;
      }
    }
  }

  bool checkReady() {
    if (player.processingState == ProcessingState.ready || player.playing) {
      ready = true;
      emitOk(player.position);
      AudioCubitPlayback.restorePosition(handler, player);
      return true;
    }
    return false;
  }
}
