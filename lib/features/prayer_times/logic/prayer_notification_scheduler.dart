import 'package:alarm/alarm.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/core/services/adhan_service.dart';
import 'package:islami_app/core/services/notification_manager.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_scheduler_methods.dart';

class PrayerNotificationScheduler {
  final AdhanService _adhanService;
  bool _isScheduling = false;

  PrayerNotificationScheduler(this._adhanService);

  Future<void> schedule(PrayerTimesResponse data) async {
    if (_isScheduling) return;
    _isScheduling = true;
    try {
      await PrayerSchedulerMethods.scheduleAll(data, _adhanService);
    } finally {
      _isScheduling = false;
    }
  }

  Future<void> toggleAdhan(bool enabled, PrayerTimesResponse? data) async {
    final box = await Hive.openBox('app_settings');
    await box.put('adhan_enabled', enabled);
    if (!enabled) {
      for (int i = 1; i <= 10; i++) {
        await Alarm.stop(i);
      }
      _adhanService.stopPrayerTimeCheck();
    } else if (data != null)
      await schedule(data);
  }

  Future<void> toggleSalahReminder(
    bool enabled,
    PrayerTimesResponse? data,
  ) async {
    final box = await Hive.openBox('app_settings');
    await box.put('salah_reminder_enabled', enabled);
    if (!enabled) {
      for (int i = 100; i <= 110; i++) {
        await Alarm.stop(i);
      }
    } else if (data != null)
      await schedule(data);
  }

  Future<void> updateSalahInterval(int hours, PrayerTimesResponse? data) async {
    final box = await Hive.openBox('app_settings');
    await box.put('salah_interval_hours', hours);
    if (data != null && box.get('salah_reminder_enabled', defaultValue: true)) {
      await schedule(data);
    }
  }

  Future<void> toggleAzkarReminder(
    bool enabled,
    PrayerTimesResponse? data,
  ) async {
    final box = await Hive.openBox('app_settings');
    await box.put('azkar_reminder_enabled', enabled);
    if (!enabled) {
      final nm = NotificationManager();
      await nm.cancelAllAzkarNotifications();
    } else if (data != null)
      await schedule(data);
  }

  Future<void> updateAzkarInterval(int hours, PrayerTimesResponse? data) async {
    final box = await Hive.openBox('app_settings');
    await box.put('azkar_interval_hours', hours);
    if (data != null && box.get('azkar_reminder_enabled', defaultValue: true)) {
      await schedule(data);
    }
  }
}
