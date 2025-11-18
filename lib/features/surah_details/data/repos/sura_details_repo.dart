import 'package:islami_app/core/networking/api_error_handler.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/core/networking/api_service.dart';
import 'package:islami_app/features/surah_details/data/models/sura_details_response_model.dart';

/// Repository for surah details data operations
class SuraDetailsRepo {
  final ApiService apiService;

  SuraDetailsRepo(this.apiService);

  Future<ApiResult<SuraDetailsResponseModel>> getSuraDetailsByNumber(
    int number,
  ) async {
    try {
      final response = await apiService.getSuraDetailsByNumber(number);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
