import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:islami_app/core/networking/api_error_model.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';

part 'ahadith_state.freezed.dart';

@freezed
class AhadithState with _$AhadithState {
  const factory AhadithState.initial() = _Initial;

  const factory AhadithState.ahadithLoading() = AhadithLoading;
  const factory AhadithState.ahadithSuccess(
    AhadithResponseModel ahadithResponseModel,
  ) = AhadithSuccess;
  const factory AhadithState.ahadithError(ApiErrorModel apiErrorModel) =
      AhadithError;
}
