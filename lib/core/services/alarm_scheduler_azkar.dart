import 'package:islami_app/core/data/azkar_list.dart';
import 'package:islami_app/core/services/notification_manager.dart';

class AzkarAlarmScheduler {
  static Future<void> schedule({int intervalHours = 3}) async {
    final notificationManager = NotificationManager();
    await notificationManager.initialize();
    await notificationManager.cancelAllAzkarNotifications();

    final int totalReminders = (24 / intervalHours).ceil();
    int reminderId = 200;

    for (int i = 1; i <= totalReminders; i++) {
      final duration = Duration(hours: intervalHours * i);
      final zikr = AzkarList.getRandomZikr();
      await notificationManager.scheduleAzkarAfter(
        reminderId++,
        zikr,
        duration,
      );
    }
  }
}
