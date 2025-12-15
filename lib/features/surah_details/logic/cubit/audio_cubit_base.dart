import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit_playback.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:just_audio/just_audio.dart';

abstract class AudioCubitBase extends Cubit<AudioState> {
  final RadioAudioHandler handler;
  late final AudioPlayer player;
  StreamSubscription<Duration>? posSub;
  StreamSubscription<PlayerState>? stateSub;
  bool ready = false;

  AudioCubitBase(this.handler) : super(const AudioState.initial()) {
    try {
      player = handler.player;
    } catch (_) {}
  }

  RepeatMode get repeatMode => handler.repeatMode;
  bool get isRepeatEnabled => handler.isRepeatEnabled;

  void emitOk(Duration p) => emit(
    AudioState.success(
      isPlaying: player.playing,
      volume: player.volume,
      position: p,
      total: player.duration ?? Duration.zero,
    ),
  );

  @override
  Future<void> close() async {
    await AudioCubitPlayback.saveState(handler, player);
    await posSub?.cancel();
    await stateSub?.cancel();
    return super.close();
  }
}
