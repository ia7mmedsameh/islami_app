import 'package:islami_app/features/radios/logic/cubit/radio_cubit_base.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';

mixin RadioCubitControls on RadioCubitBase {
  void pause() {
    if (isClosed) return;
    handler.pause();
    emit(RadioState.paused(volume: player.volume));
  }

  void resume() {
    if (isClosed) return;
    handler.play();
    emit(RadioState.playing(volume: player.volume));
  }

  void setVolume(double v) {
    if (isClosed) return;
    handler.setVolume(v);
    emit(
      player.playing
          ? RadioState.playing(volume: v)
          : RadioState.paused(volume: v),
    );
  }

  void connectToExistingPlayer() {
    stateSub?.cancel();
    emit(
      player.playing
          ? RadioState.playing(volume: player.volume)
          : RadioState.paused(volume: player.volume),
    );
    stateSub = player.playerStateStream.listen((s) {
      if (isClosed) return;
      emit(
        s.playing
            ? RadioState.playing(volume: player.volume)
            : RadioState.paused(volume: player.volume),
      );
    });
  }
}
