import 'package:dio/dio.dart';
import 'package:islami_app/core/networking/api_constants.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';
import 'package:islami_app/features/home/data/models/surahs_response_model.dart';
import 'package:islami_app/features/surah_details/data/models/sura_details_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiConstants.surah)
  Future<SurahsResponseModel> getAllSurahs();

  @GET(ApiConstants.surahByNumber)
  Future<SuraDetailsResponseModel> getSuraDetailsByNumber(
    @Path('number') int number,
  );
}

@RestApi(baseUrl: ApiConstants.apiBaseUrlAhadith)
abstract class HadithApiService {
  factory HadithApiService(Dio dio, {String baseUrl}) = _HadithApiService;

  @GET(ApiConstants.ahadith)
  Future<AhadithResponseModel> getAllHadiths({
    @Query('apiKey') String apiKey = ApiConstants.apiKey,
  });
}
