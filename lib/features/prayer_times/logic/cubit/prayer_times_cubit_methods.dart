import 'package:geolocator/geolocator.dart';
import 'package:islami_app/core/networking/api_result.dart' as api;
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/data/repos/prayer_times_repo.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_state.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_cache_manager.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_notification_scheduler.dart';

class PrayerTimesCubitMethods {
  static Future<void> fetchPrayerTimes(
    PrayerTimesRepo repo,
    PrayerNotificationScheduler scheduler,
    void Function(PrayerTimesState) emit,
  ) async {
    try {
      final cached = await PrayerCacheManager.load();
      if (cached != null) {
        emit(PrayerTimesState.success(cached));
        if (PrayerCacheManager.isValid(cached)) {
          await scheduler.schedule(cached);
          return;
        }
      }
      // التحقق من الصلاحية بدون طلبها
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (cached == null) {
          emit(
            const PrayerTimesState.error(
              'صلاحية الموقع غير مفعلة\nيرجى تفعيل صلاحية الموقع من إعدادات التطبيق لعرض أوقات الصلاة',
            ),
          );
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );
      final result = await repo.getPrayerTimes(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      if (result is api.Success<PrayerTimesResponse>) {
        emit(PrayerTimesState.success(result.data));
        await PrayerCacheManager.save(result.data);
        await scheduler.schedule(result.data);
      } else if (cached == null) {
        final failure = result as api.Failure;
        emit(PrayerTimesState.error(failure.apiErrorModel.data ?? 'حدث خطأ'));
      }
    } on LocationServiceDisabledException {
      final cached = await PrayerCacheManager.load();
      if (cached == null) {
        emit(
          const PrayerTimesState.error(
            'خدمة الموقع غير مفعلة\nيرجى تفعيل GPS من إعدادات الجهاز',
          ),
        );
      }
    } catch (_) {
      final cached = await PrayerCacheManager.load();
      if (cached == null) {
        emit(const PrayerTimesState.error('حدث خطأ أثناء جلب أوقات الصلاة'));
      }
    }
  }
}
