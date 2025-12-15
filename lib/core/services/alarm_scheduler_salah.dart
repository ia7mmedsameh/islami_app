import 'package:alarm/alarm.dart';

class SalahAlarmScheduler {
  static Future<void> schedule(
    Map<String, DateTime> prayerTimes, {
    int intervalHours = 4,
    bool vibrate = false,
  }) async {
    for (int i = 100; i <= 110; i++) {
      await Alarm.stop(i);
    }

    final now = DateTime.now();
    final List<DateTime> reminderTimes = [];

    for (int hour = 0; hour < 24; hour += intervalHours) {
      final reminderTime = DateTime(now.year, now.month, now.day, hour, 0);
      if (reminderTime.isAfter(now)) reminderTimes.add(reminderTime);
    }

    if (reminderTimes.isEmpty || reminderTimes.length < 2) {
      final tomorrow = now.add(const Duration(days: 1));
      for (int hour = 0; hour < 24; hour += intervalHours) {
        reminderTimes.add(
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, hour, 0),
        );
        if (reminderTimes.length >= 6) break;
      }
    }

    int reminderId = 100;
    for (var reminderTime in reminderTimes) {
      if (!_conflictsWithPrayer(reminderTime, prayerTimes)) {
        await _scheduleAlarm(reminderId++, reminderTime, vibrate: vibrate);
      }
    }
  }

  static bool _conflictsWithPrayer(
    DateTime reminderTime,
    Map<String, DateTime> prayerTimes,
  ) {
    return prayerTimes.values.any(
      (prayerTime) => reminderTime.difference(prayerTime).inMinutes.abs() < 15,
    );
  }

  static Future<void> _scheduleAlarm(
    int id,
    DateTime time, {
    bool vibrate = false,
  }) async {
    await Alarm.set(
      alarmSettings: AlarmSettings(
        id: id,
        dateTime: time,
        assetAudioPath: 'assets/saly_3la_muhammed/salah.mp3',
        loopAudio: false,
        vibrate: vibrate,
        volumeSettings: const VolumeSettings.fixed(
          volume: 0.7,
          volumeEnforced: true,
        ),
        warningNotificationOnKill: false,
        androidFullScreenIntent: false,
        notificationSettings: const NotificationSettings(
          title: '🤲 تذكير بالصلاة على النبي',
          body: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
          stopButton: 'إيقاف',
          icon: 'notification_icon',
        ),
      ),
    );
  }
}
