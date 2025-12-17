import 'package:hive/hive.dart';
import 'package:islami_app/core/services/adhan_service.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_time_calculator.dart';
import 'package:permission_handler/permission_handler.dart';

class PrayerSchedulerMethods {
  static Future<void> scheduleAll(
    PrayerTimesResponse data,
    AdhanService adhanService,
  ) async {
    final prayerTimes = PrayerTimeCalculator.getPrayerTimes(data.data.timings);
    final box = await Hive.openBox('app_settings');
    final adhanEnabled = box.get('adhan_enabled', defaultValue: true);
    final adhanVibrate = box.get('adhan_vibrate', defaultValue: false);
    final salahEnabled = box.get('salah_reminder_enabled', defaultValue: true);
    final salahInterval = box.get('salah_interval_hours', defaultValue: 4);
    final salahVibrate = box.get('salah_vibrate', defaultValue: false);

    // التحقق من صلاحية الإشعارات للأذكار
    final notificationStatus = await Permission.notification.status;
    final azkarEnabled =
        notificationStatus.isGranted &&
        box.get('azkar_reminder_enabled', defaultValue: false);
    final azkarInterval = box.get('azkar_interval_hours', defaultValue: 3);
    final azkarVibrate = box.get('azkar_vibrate', defaultValue: false);

    if (adhanEnabled) {
      adhanService.schedulePrayerNotifications(
        prayerTimes: prayerTimes,
        vibrate: adhanVibrate,
      );
    }
    if (salahEnabled) {
      adhanService.scheduleSalahReminders(
        prayerTimes: prayerTimes,
        intervalHours: salahInterval,
        vibrate: salahVibrate,
      );
    }
    if (azkarEnabled) {
      adhanService.scheduleAzkarReminders(
        prayerTimes: prayerTimes,
        intervalHours: azkarInterval,
        vibrate: azkarVibrate,
      );
    }
  }
}
