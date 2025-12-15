import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit_base.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit_controls.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit_methods.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit_navigation.dart';

class RadioCubit extends RadioCubitBase with RadioCubitControls {
  Future<void> setRadio(String url, String name) async {
    try {
      await player.stop();
    } catch (_) {}
    emit(const RadioState.loading());
    try {
      await handler.playRadio(url, name);
      try {
        getIt<GlobalAudioManager>().playRadio(radioUrl: url, radioName: name);
      } catch (_) {}
      RadioCubitMethods.updateAudioType();
      emit(RadioState.playing(volume: player.volume));
      await stateSub?.cancel();
      stateSub = player.playerStateStream.listen((s) {
        if (isClosed) return;
        emit(
          s.playing
              ? RadioState.playing(volume: player.volume)
              : RadioState.paused(volume: player.volume),
        );
      });
    } catch (_) {
      if (!isClosed) emit(const RadioState.error("حدث خطأ"));
    }
  }

  void playNext(List<dynamic> r, String url) {
    final i = RadioCubitNavigation.findNextIndex(r, url);
    if (i != null) setRadio(r[i].url ?? '', r[i].name ?? '');
  }

  void playPrevious(List<dynamic> r, String url) {
    final i = RadioCubitNavigation.findPreviousIndex(r, url);
    if (i != null) setRadio(r[i].url ?? '', r[i].name ?? '');
  }
}
