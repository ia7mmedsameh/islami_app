import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_state.freezed.dart';

@freezed
class RadioState with _$RadioState {
  const factory RadioState.initial() = _Initial;

  const factory RadioState.loading() = Loading;

  const factory RadioState.playing({
    required double volume,
  }) = Playing;

  const factory RadioState.paused({
    required double volume,
  }) = Paused;

  const factory RadioState.error(String message) = Error;
}
