import 'package:dio/dio.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';
import 'package:islami_app/features/radios/ui/helper/radio_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'radio_api_service.g.dart';

@RestApi(baseUrl: RadioConstants.baseUrl)
abstract class RadioApiService {
  factory RadioApiService(Dio dio, {String baseUrl}) = _RadioApiService;

  @GET(RadioConstants.radiosEndpoint)
  Future<RadioResponseModel> getAllRadios({
    @Query('language') String language = RadioConstants.language,
  });
}
