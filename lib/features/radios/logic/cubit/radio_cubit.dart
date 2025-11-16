import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/radios/logic/audio_handler/audio_service_helper.dart';
import 'package:islami_app/features/radios/logic/audio_handler/radio_audio_handler.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:just_audio/just_audio.dart';

class RadioCubit extends Cubit<AudioState> {
  final RadioAudioHandler _handler = AudioServiceHelper.handler;
  StreamSubscription<PlayerState>? _sub;

  RadioCubit() : super(const AudioState.initial()) {
    _listen();
  }

  void _listen() {
    _sub = _handler.player.playerStateStream.listen((s) {
      final playing = s.playing;

      emit(
        AudioState.success(
          isPlaying: playing,
          volume: _handler.player.volume,
          position: Duration.zero,
          total: Duration.zero,
        ),
      );
    });
  }

  Future<void> setRadio(String url, String name) async {
    emit(const AudioState.loading());
    await _handler.playRadio(url, name);
  }

  Future<void> pause() => _handler.pause();

  Future<void> resume() => _handler.play();

  Future<void> setVolume(double v) async {
    await _handler.setVolume(v);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
