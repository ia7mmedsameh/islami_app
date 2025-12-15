import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_audio_state.freezed.dart';

@freezed
class GlobalAudioState with _$GlobalAudioState {
  const factory GlobalAudioState.idle() = Idle;

  const factory GlobalAudioState.loading() = Loading;

  const factory GlobalAudioState.playingQuran({
    required int surahNumber,
    required String surahName,
    required bool isPlaying,
    required double volume,
    required Duration position,
    required Duration total,
  }) = PlayingQuran;

  const factory GlobalAudioState.playingRadio({
    required String radioUrl,
    required String radioName,
    required bool isPlaying,
    required double volume,
  }) = PlayingRadio;

  const factory GlobalAudioState.error(String message) = Error;
}
