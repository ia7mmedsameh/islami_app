import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/features/radios/logic/audio_handler/audio_service_helper.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';
import 'package:just_audio/just_audio.dart';

abstract class RadioCubitBase extends Cubit<RadioState> {
  late final RadioAudioHandler handler;
  late final AudioPlayer player;
  StreamSubscription<PlayerState>? stateSub;

  RadioCubitBase() : super(const RadioState.initial()) {
    try {
      handler = AudioServiceHelper.handler;
      player = handler.player;
    } catch (_) {
      handler = getIt<RadioAudioHandler>();
      player = handler.player;
    }
  }

  void connectToExistingPlayer() {
    // لو الصوت شغال أصلاً، نعرض الـ controls مباشرة بدون loading
    if (player.playing) {
      emit(RadioState.playing(volume: player.volume));
    } else {
      emit(RadioState.paused(volume: player.volume));
    }
    // نستمع للتغييرات
    stateSub?.cancel();
    stateSub = player.playerStateStream.listen((s) {
      if (isClosed) return;
      emit(
        s.playing
            ? RadioState.playing(volume: player.volume)
            : RadioState.paused(volume: player.volume),
      );
    });
  }

  @override
  Future<void> close() async {
    await stateSub?.cancel();
    return super.close();
  }
}
