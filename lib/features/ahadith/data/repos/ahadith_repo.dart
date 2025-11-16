import 'package:islami_app/core/networking/api_error_handler.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/core/networking/api_service.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';

class AhadithRepo {
  final HadithApiService hadithApiService;

  AhadithRepo(this.hadithApiService);

  Future<ApiResult<AhadithResponseModel>> getAllHadiths() async {
    try {
      final response = await hadithApiService.getAllHadiths();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
