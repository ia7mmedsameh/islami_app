import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tzl;
import 'package:islami_app/core/services/notification_manager_show.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._();
  factory NotificationManager() => _instance;
  NotificationManager._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    tz.initializeTimeZones();
    tzl.setLocalLocation(tzl.getLocation('Africa/Cairo'));
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    await _notifications.initialize(settings);
    await _requestPermissions();
    _isInitialized = true;
  }

  Future<void> _requestPermissions() async {
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  Future<void> show(int id, String title, String body) async =>
      await NotificationManagerShow.show(_notifications, id, title, body);
  Future<void> showAzkarNotification(int id, String zikr) async =>
      await NotificationManagerShow.showAzkar(_notifications, id, zikr);
  Future<void> scheduleAzkarAfter(
    int id,
    String zikr,
    Duration duration,
  ) async => await NotificationManagerShow.scheduleAzkar(
    _notifications,
    id,
    zikr,
    duration,
  );
  Future<void> cancel(int id) async => await _notifications.cancel(id);
  Future<void> cancelAllAzkarNotifications() async {
    for (int i = 200; i <= 224; i++) await _notifications.cancel(i);
  }
}
