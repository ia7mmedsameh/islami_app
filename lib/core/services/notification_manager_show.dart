import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationManagerShow {
  static Future<void> show(
    FlutterLocalNotificationsPlugin notifications,
    int id,
    String title,
    String body,
  ) async {
    await notifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'welcome_channel',
          'إشعارات الترحيب',
          channelDescription: 'إشعار ترحيبي',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
    );
  }

  static Future<void> showAzkar(
    FlutterLocalNotificationsPlugin notifications,
    int id,
    String zikr,
  ) async {
    await notifications.show(
      id,
      '💭 تذكير بالذكر',
      zikr,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'azkar_channel',
          'تذكير بالأذكار',
          channelDescription: 'إشعارات التذكير بالأذكار',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          enableVibration: false,
          styleInformation: BigTextStyleInformation(zikr),
        ),
      ),
    );
  }

  static Future<void> scheduleAzkar(
    FlutterLocalNotificationsPlugin notifications,
    int id,
    String zikr,
    Duration duration,
  ) async {
    final tzTime = tz.TZDateTime.now(tz.local).add(duration);
    try {
      await notifications.zonedSchedule(
        id,
        '💭 تذكير بالذكر',
        zikr,
        tzTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'azkar_channel',
            'تذكير بالأذكار',
            channelDescription: 'إشعارات التذكير بالأذكار',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: false,
            styleInformation: BigTextStyleInformation(zikr),
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (_) {
      // Fallback: schedule with inexact timing
      try {
        await notifications.zonedSchedule(
          id,
          '💭 تذكير بالذكر',
          zikr,
          tzTime,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'azkar_channel',
              'تذكير بالأذكار',
              channelDescription: 'إشعارات التذكير بالأذكار',
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              enableVibration: false,
              styleInformation: BigTextStyleInformation(zikr),
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (_) {}
    }
  }
}
