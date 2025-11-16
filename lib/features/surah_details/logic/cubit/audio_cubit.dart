import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_state.dart';
import 'package:islami_app/features/surah_details/ui/helper/audio_constants.dart';
import 'package:islami_app/features/radios/logic/audio_handler/radio_audio_handler.dart';

class AudioCubit extends Cubit<AudioState> {
  final RadioAudioHandler _audioHandler;
  late final AudioPlayer _audioPlayer;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  AudioCubit(this._audioHandler) : super(const AudioState.initial()) {
    _audioPlayer = _audioHandler.player; // نفس البلاير بتاع الراديو
  }

  Future<void> setAudioSource(int surahNumber, String surahName) async {
    if (isClosed) return;
    emit(const AudioState.loading());
    try {
      final url128 = AudioConstants.getSurahUrl(
        surahNumber: surahNumber,
        bitrate: AudioConstants.bitrate128,
      );
      final url64 = AudioConstants.getSurahUrl(
        surahNumber: surahNumber,
        bitrate: AudioConstants.bitrate64,
      );

      String finalUrl;

      try {
        await _audioPlayer.setUrl(url128);
        finalUrl = url128;
      } catch (_) {
        await _audioPlayer.setUrl(url64);
        finalUrl = url64;
      }

      if (isClosed) return;

      // 🟡 مهم: نحط ميتا داتا للقرآن عشان النوتفيكيشن
      await _audioHandler.setQuranMedia(
        url: finalUrl,
        surahName: surahName,
        surahNumber: surahNumber,
      );

      emit(
        AudioState.success(
          isPlaying: _audioPlayer.playing,
          volume: _audioPlayer.volume,
          position: Duration.zero,
          total: _audioPlayer.duration ?? Duration.zero,
        ),
      );

      _positionSub?.cancel();
      _positionSub = _audioPlayer.positionStream.listen((position) {
        if (!isClosed && state is Success) {
          final current = state as Success;
          emit(current.copyWith(position: position));
        }
      });

      _playerStateSub?.cancel();
      _playerStateSub = _audioPlayer.playerStateStream.listen((playerState) async {
        if (!isClosed && state is Success) {
          final current = state as Success;

          if (playerState.processingState == ProcessingState.completed) {
            await _audioPlayer.seek(Duration.zero);
            await _audioPlayer.play();
          }

          bool playing = _audioPlayer.playing;
          emit(current.copyWith(isPlaying: playing));
        }
      });

      await _audioPlayer.play();
    } catch (e) {
      if (!isClosed) {
        emit(const AudioState.error('حدث خطأ غير متوقع'));
      }
    }
  }

  void pause() => _audioPlayer.pause();

  void resume() => _audioPlayer.play();

  void seek(Duration position) => _audioPlayer.seek(position);

  void setVolume(double volume) => _audioPlayer.setVolume(volume);

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _playerStateSub?.cancel();
    // مهم: منوحش نعمل dispose هنا لأن نفس البلاير مستخدم في الراديو
    return super.close();
  }
}
