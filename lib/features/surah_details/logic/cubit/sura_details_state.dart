import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:islami_app/core/networking/api_error_model.dart';
import 'package:islami_app/features/surah_details/data/models/sura_details_response_model.dart';
part 'sura_details_state.freezed.dart';

@freezed
class SuraDetailsState with _$SuraDetailsState {
  const factory SuraDetailsState.initial() = _Initial;

  const factory SuraDetailsState.suraDetailsStateLoading() =
      SuraDetailsStateLoading;
  const factory SuraDetailsState.suraDetailsStateSuccess(
    SuraDetailsResponseModel suraDetailsResponseModel,
  ) = SuraDetailsStateSuccess;
  const factory SuraDetailsState.suraDetailsStateError(
    ApiErrorModel apiErrorModel,
  ) = SuraDetailsStateError;
}
