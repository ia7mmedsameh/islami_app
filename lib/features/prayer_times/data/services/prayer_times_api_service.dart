import 'package:dio/dio.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:retrofit/retrofit.dart';

part 'prayer_times_api_service.g.dart';

@RestApi(baseUrl: 'https://api.aladhan.com/v1/')
abstract class PrayerTimesApiService {
  factory PrayerTimesApiService(Dio dio, {String baseUrl}) =
      _PrayerTimesApiService;

  @GET('timings/{timestamp}')
  Future<PrayerTimesResponse> getPrayerTimes(
    @Path('timestamp') int timestamp,
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('method') int method,
  );
}
