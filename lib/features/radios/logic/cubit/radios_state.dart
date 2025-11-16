import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';

part 'radios_state.freezed.dart';

@freezed
class RadiosState with _$RadiosState {
  const factory RadiosState.initial() = _Initial;

  const factory RadiosState.radiosLoading() = RadiosLoading;

  const factory RadiosState.radiosSuccess(
    RadioResponseModel radioResponseModel,
  ) = RadiosSuccess;

  const factory RadiosState.radiosError(String message) = RadiosError;
}
