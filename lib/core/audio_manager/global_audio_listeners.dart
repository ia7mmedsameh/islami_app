import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/core/audio_manager/global_audio_state.dart';
import 'package:just_audio/just_audio.dart';

class GlobalAudioListeners {
  static StreamSubscription<MediaItem?>? setupMediaItemListener(
    RadioAudioHandler handler,
    AudioPlayer player,
    bool Function() isClosed,
    void Function(GlobalAudioState) emit,
    int? Function(String) extractSurahNumber,
  ) {
    return handler.mediaItem.listen((mediaItem) {
      if (isClosed() || mediaItem == null) return;
      if (mediaItem.artist == "تلاوة القرآن الكريم") {
        final surahNumber = extractSurahNumber(mediaItem.album ?? '');
        if (surahNumber != null) {
          emit(
            GlobalAudioState.playingQuran(
              surahNumber: surahNumber,
              surahName: mediaItem.title,
              isPlaying: player.playing,
              volume: player.volume,
              position: player.position,
              total: mediaItem.duration ?? player.duration ?? Duration.zero,
            ),
          );
        }
      } else if (mediaItem.artist == "راديو") {
        emit(
          GlobalAudioState.playingRadio(
            radioUrl: mediaItem.id,
            radioName: mediaItem.title,
            isPlaying: player.playing,
            volume: player.volume,
          ),
        );
      }
    });
  }

  static StreamSubscription<Duration>? setupPositionListener(
    AudioPlayer player,
    bool Function() isClosed,
    GlobalAudioState Function() getState,
    void Function(GlobalAudioState) emit,
  ) {
    return player.positionStream.listen((position) {
      if (isClosed()) return;
      final currentState = getState();
      if (currentState is PlayingQuran) {
        emit(currentState.copyWith(position: position));
      }
    });
  }

  static StreamSubscription<PlayerState>? setupStateListener(
    AudioPlayer player,
    bool Function() isClosed,
    GlobalAudioState Function() getState,
    void Function(GlobalAudioState) emit,
  ) {
    return player.playerStateStream.listen((playerState) {
      if (isClosed()) return;
      final currentState = getState();
      if (currentState is PlayingQuran) {
        emit(
          currentState.copyWith(
            isPlaying: playerState.playing,
            total: player.duration ?? currentState.total,
          ),
        );
      } else if (currentState is PlayingRadio) {
        emit(currentState.copyWith(isPlaying: playerState.playing));
      }
    });
  }

  static StreamSubscription<Duration?>? setupDurationListener(
    AudioPlayer player,
    bool Function() isClosed,
    GlobalAudioState Function() getState,
    void Function(GlobalAudioState) emit,
  ) {
    return player.durationStream.listen((duration) {
      if (isClosed() || duration == null) return;
      final currentState = getState();
      if (currentState is PlayingQuran) {
        emit(currentState.copyWith(total: duration));
      }
    });
  }
}
