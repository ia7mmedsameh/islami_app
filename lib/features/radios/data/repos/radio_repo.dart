import 'package:islami_app/core/networking/api_error_handler.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';
import 'package:islami_app/features/radios/data/services/radio_api_service.dart';

class RadioRepo {
  final RadioApiService radioApiService;

  RadioRepo(this.radioApiService);

  Future<ApiResult<RadioResponseModel>> getAllRadios() async {
    try {
      final response = await radioApiService.getAllRadios();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
