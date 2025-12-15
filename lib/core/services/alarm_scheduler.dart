import 'package:alarm/alarm.dart';
import 'package:islami_app/core/services/alarm_scheduler_prayer.dart';
import 'package:islami_app/core/services/alarm_scheduler_salah.dart';
import 'package:islami_app/core/services/alarm_scheduler_azkar.dart';

class AlarmScheduler {
  static bool _isInitialized = false;

  static void initializeAutoStop() {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  static Future<void> schedulePrayerAlarms(
    Map<String, DateTime> prayerTimes, {
    bool vibrate = true,
  }) async {
    await Alarm.init();
    initializeAutoStop();
    await PrayerAlarmScheduler.schedule(prayerTimes, vibrate: vibrate);
  }

  static Future<void> scheduleSalahReminders(
    Map<String, DateTime> prayerTimes, {
    int intervalHours = 4,
    bool vibrate = false,
  }) async {
    await Alarm.init();
    initializeAutoStop();
    await SalahAlarmScheduler.schedule(
      prayerTimes,
      intervalHours: intervalHours,
      vibrate: vibrate,
    );
  }

  static Future<void> scheduleAzkarReminders(
    Map<String, DateTime> prayerTimes, {
    int intervalHours = 3,
    bool vibrate = false,
  }) async {
    await AzkarAlarmScheduler.schedule(intervalHours: intervalHours);
  }
}
