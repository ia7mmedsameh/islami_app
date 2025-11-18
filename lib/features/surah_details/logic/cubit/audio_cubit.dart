import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/ui/helper/audio_constants.dart';
import 'package:islami_app/core/audio_handler/radio_audio_handler.dart';
import 'package:just_audio/just_audio.dart';

class AudioCubit extends Cubit<AudioState> {
  final RadioAudioHandler _handler;
  late final AudioPlayer _player;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<PlayerState>? _stateSub;
  bool _sentReady = false;

  AudioCubit(this._handler) : super(const AudioState.initial()) {
    _player = _handler.player;
  }

  Future<void> setAudioSource(int surahNumber, String surahName) async {
    emit(const AudioState.loading());
    _sentReady = false;
    try {
      final url = AudioConstants.getSurahUrl(
        surahNumber: surahNumber,
        bitrate: AudioConstants.bitrate128,
      );
      _posSub?.cancel();
      _stateSub?.cancel();
      _posSub = _player.positionStream.listen((p) {
        if (isClosed || !_sentReady) return;
        if (state is Success) {
          emit((state as Success).copyWith(position: p));
        } else if (_player.playing)
          _emitSuccess(p);
      });
      _stateSub = _player.playerStateStream.listen((s) async {
        if (isClosed) return;
        if (!_sentReady &&
            (s.processingState == ProcessingState.ready || s.playing)) {
          _checkReady();
        }
        if (_sentReady && state is Success) {
          emit(
            (state as Success).copyWith(
              isPlaying: _player.playing,
              total: _player.duration ?? Duration.zero,
            ),
          );
        }
        if (s.processingState == ProcessingState.completed) {
          await _player.seek(Duration.zero);
          await _player.play();
        }
      });
      _player.durationStream.listen((d) {
        if (_sentReady && d != null && state is Success && !isClosed) {
          emit((state as Success).copyWith(total: d));
        }
      });
      await _handler.setQuranMedia(
        url: url,
        surahName: surahName,
        surahNumber: surahNumber,
      );
      if (!_sentReady) {
        try {
          await _player.playerStateStream
              .timeout(const Duration(seconds: 2))
              .firstWhere(
                (s) => s.processingState == ProcessingState.ready || s.playing,
              );
          _checkReady();
        } catch (_) {
          for (int i = 0; i < 20; i++) {
            await Future.delayed(const Duration(milliseconds: 50));
            if (isClosed || _sentReady || _checkReady()) break;
          }
        }
      }
    } catch (_) {
      if (!isClosed) emit(const AudioState.error("حدث خطأ أثناء تشغيل السورة"));
    }
  }

  bool _checkReady() {
    if (_player.processingState == ProcessingState.ready || _player.playing) {
      _sentReady = true;
      _emitSuccess(_player.position);
      return true;
    }
    return false;
  }

  void _emitSuccess(Duration position) {
    emit(
      AudioState.success(
        isPlaying: _player.playing,
        volume: _player.volume,
        position: position,
        total: _player.duration ?? Duration.zero,
      ),
    );
  }

  void pause() => isClosed ? null : _player.pause();
  void resume() => isClosed ? null : _player.play();
  void seek(Duration p) => isClosed ? null : _player.seek(p);
  void setVolume(double v) => isClosed ? null : _player.setVolume(v);

  @override
  Future<void> close() async {
    await _posSub?.cancel();
    await _stateSub?.cancel();
    return super.close();
  }
}
