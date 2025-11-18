import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/radios/logic/audio_handler/audio_service_helper.dart';
import 'package:islami_app/core/audio_handler/radio_audio_handler.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';
import 'package:just_audio/just_audio.dart';

class RadioCubit extends Cubit<RadioState> {
  late final RadioAudioHandler _handler;
  late final AudioPlayer _player;

  StreamSubscription<PlayerState>? _stateSub;

  RadioCubit() : super(const RadioState.initial()) {
    _handler = AudioServiceHelper.handler;
    _player = _handler.player;
  }

  Future<void> setRadio(String url, String name) async {
    emit(const RadioState.loading());

    try {
      await _handler.playRadio(url, name);

      /// أول ما يشتغل الصوت نطلع من اللودينج فوراً
      emit(RadioState.playing(volume: _player.volume));

      await _stateSub?.cancel();
      _stateSub = _player.playerStateStream.listen((playerState) {
        if (isClosed) return;

        /// أهم شرط يعالج المشكلة:
        if (playerState.playing) {
          emit(RadioState.playing(volume: _player.volume));
          return;
        }

        emit(RadioState.paused(volume: _player.volume));
      });
    } catch (_) {
      if (!isClosed) {
        emit(const RadioState.error("حدث خطأ أثناء تشغيل الراديو"));
      }
    }
  }

  void pause() {
    if (isClosed) return;
    _handler.pause();
    emit(RadioState.paused(volume: _player.volume));
  }

  void resume() {
    if (isClosed) return;
    _handler.play();
    emit(RadioState.playing(volume: _player.volume));
  }

  void setVolume(double v) {
    if (isClosed) return;
    _handler.setVolume(v);
    emit(
      _player.playing
          ? RadioState.playing(volume: v)
          : RadioState.paused(volume: v),
    );
  }

  @override
  Future<void> close() async {
    await _stateSub?.cancel();
    return super.close();
  }
}
