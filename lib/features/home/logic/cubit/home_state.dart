import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:islami_app/core/networking/api_error_model.dart';
import 'package:islami_app/features/home/data/models/surahs_response_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  const factory HomeState.surahsLoading() = SurahsLoading;
  const factory HomeState.surahsSuccess(
    SurahsResponseModel surahsResponseModel,
  ) = SurahsSuccess;
  const factory HomeState.surahsError(ApiErrorModel apiErrorModel) =
      SurahsError;
}
