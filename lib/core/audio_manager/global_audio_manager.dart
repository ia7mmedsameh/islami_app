import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/core/audio_manager/global_audio_state.dart';
import 'package:islami_app/core/audio_manager/global_audio_listeners.dart';
import 'package:just_audio/just_audio.dart';

class GlobalAudioManager extends Cubit<GlobalAudioState> {
  final RadioAudioHandler _handler;
  late final AudioPlayer _player;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription? _mediaItemSub;

  GlobalAudioManager(this._handler) : super(const GlobalAudioState.idle()) {
    _player = _handler.player;
    _initListeners();
  }

  void _initListeners() {
    _mediaItemSub = GlobalAudioListeners.setupMediaItemListener(
      _handler,
      _player,
      () => isClosed,
      emit,
      _extractSurahNumber,
    );
    _posSub = GlobalAudioListeners.setupPositionListener(
      _player,
      () => isClosed,
      () => state,
      emit,
    );
    _stateSub = GlobalAudioListeners.setupStateListener(
      _player,
      () => isClosed,
      () => state,
      emit,
    );
    _durationSub = GlobalAudioListeners.setupDurationListener(
      _player,
      () => isClosed,
      () => state,
      emit,
    );
  }

  Future<void> playQuran({
    required int surahNumber,
    required String surahName,
    bool actuallyPlay = false,
  }) async {
    emit(
      GlobalAudioState.playingQuran(
        surahNumber: surahNumber,
        surahName: surahName,
        isPlaying: true,
        volume: _player.volume,
        position: Duration.zero,
        total: _player.duration ?? Duration.zero,
      ),
    );
  }

  void playRadio({required String radioUrl, required String radioName}) {
    emit(
      GlobalAudioState.playingRadio(
        radioUrl: radioUrl,
        radioName: radioName,
        isPlaying: true,
        volume: _player.volume,
      ),
    );
  }

  void pause() {
    if (!isClosed) _handler.pause();
  }

  void resume() {
    if (!isClosed) _handler.play();
  }

  void seek(Duration position) {
    if (!isClosed) _handler.seek(position);
  }

  void setVolume(double volume) {
    if (!isClosed) _handler.setVolume(volume);
  }

  Future<void> stop() async {
    if (isClosed) return;
    await _handler.stop();
    emit(const GlobalAudioState.idle());
  }

  int? _extractSurahNumber(String album) {
    final regex = RegExp(r'سورة رقم (\d+)');
    final match = regex.firstMatch(album);
    return match != null ? int.tryParse(match.group(1) ?? '') : null;
  }

  @override
  Future<void> close() async {
    await _posSub?.cancel();
    await _stateSub?.cancel();
    await _durationSub?.cancel();
    await _mediaItemSub?.cancel();
    return super.close();
  }
}
