import 'package:alarm/alarm.dart';

class PrayerAlarmScheduler {
  static Future<void> schedule(
    Map<String, DateTime> prayerTimes, {
    bool vibrate = false,
  }) async {
    for (int i = 1; i <= 10; i++) {
      try {
        await Alarm.stop(i);
      } catch (_) {}
    }

    final now = DateTime.now();
    int alarmId = 1;

    for (var entry in prayerTimes.entries) {
      DateTime alarmTime = entry.value;
      if (alarmTime.isBefore(now) || alarmTime.isAtSameMomentAs(now)) {
        alarmTime = alarmTime.add(const Duration(days: 1));
      }
      try {
        await _scheduleAlarm(
          id: alarmId++,
          time: alarmTime,
          name: entry.key,
          isFajr: entry.key == 'الفجر',
          vibrate: vibrate,
        );
      } catch (_) {}
    }
  }

  static Future<void> _scheduleAlarm({
    required int id,
    required DateTime time,
    required String name,
    required bool isFajr,
    bool vibrate = false,
  }) async {
    final assetPath = isFajr
        ? 'assets/alazan/adhan_fajr.mp3'
        : 'assets/alazan/adhan_normal.mp3';
    await Alarm.set(
      alarmSettings: AlarmSettings(
        id: id,
        dateTime: time,
        assetAudioPath: assetPath,
        loopAudio: false,
        vibrate: vibrate,
        volumeSettings: const VolumeSettings.fixed(
          volume: 0.8,
          volumeEnforced: true,
        ),
        warningNotificationOnKill: true,
        androidFullScreenIntent: false,
        notificationSettings: NotificationSettings(
          title: 'حان وقت صلاة $name',
          body: 'اضغط لإيقاف الأذان',
          stopButton: 'إيقاف',
          icon: 'notification_icon',
        ),
      ),
    );
  }
}
