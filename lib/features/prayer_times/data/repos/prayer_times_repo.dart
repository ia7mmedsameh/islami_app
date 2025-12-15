import 'package:islami_app/core/networking/api_error_handler.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/data/services/prayer_times_api_service.dart';

class PrayerTimesRepo {
  final PrayerTimesApiService _apiService;

  PrayerTimesRepo(this._apiService);

  Future<ApiResult<PrayerTimesResponse>> getPrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      int method = 3;

      if (_inRange(latitude, longitude, 22, 32, 25, 37)) {
        method = 5;
      } else if (_inRange(latitude, longitude, 12, 32, 34, 60)) {
        method = 4;
      } else if (_inRange(latitude, longitude, 36, 42, 26, 45)) {
        method = 13;
      } else if (_inRange(latitude, longitude, 25, 40, 44, 75)) {
        method = 7;
      } else if (_inRange(latitude, longitude, 8, 37, 60, 97)) {
        method = 1;
      } else if (_inRange(latitude, longitude, -11, 7, 95, 141)) {
        method = 11;
      } else if (_inRange(latitude, longitude, 25, 72, -170, -50)) {
        method = 2;
      } else if (_inRange(latitude, longitude, 15, 37, -17, 49)) {
        method = 3;
      }

      final response = await _apiService.getPrayerTimes(
        timestamp,
        latitude,
        longitude,
        method,
      );

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  bool _inRange(
    double lat,
    double lon,
    double minLat,
    double maxLat,
    double minLon,
    double maxLon,
  ) {
    return lat >= minLat && lat <= maxLat && lon >= minLon && lon <= maxLon;
  }
}
