import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:islami_app/core/services/alarm_scheduler.dart';
import 'package:islami_app/core/services/notification_manager.dart';

class AdhanService {
  static final AdhanService _instance = AdhanService._();
  factory AdhanService() => _instance;
  AdhanService._();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final NotificationManager _notificationManager = NotificationManager();
  Timer? _checkTimer;

  Future<void> initialize() async => await _notificationManager.initialize();

  Future<void> schedulePrayerNotifications({
    required Map<String, DateTime> prayerTimes,
    bool vibrate = true,
  }) async =>
      await AlarmScheduler.schedulePrayerAlarms(prayerTimes, vibrate: vibrate);
  Future<void> scheduleSalahReminders({
    required Map<String, DateTime> prayerTimes,
    int intervalHours = 4,
    bool vibrate = false,
  }) async => await AlarmScheduler.scheduleSalahReminders(
    prayerTimes,
    intervalHours: intervalHours,
    vibrate: vibrate,
  );
  Future<void> scheduleAzkarReminders({
    required Map<String, DateTime> prayerTimes,
    int intervalHours = 3,
    bool vibrate = false,
  }) async => await AlarmScheduler.scheduleAzkarReminders(
    prayerTimes,
    intervalHours: intervalHours,
    vibrate: vibrate,
  );

  Future<void> playAdhan({required bool isFajr}) async {
    try {
      final assetPath = isFajr
          ? 'assets/alazan/adhan_fajr.mp3'
          : 'assets/alazan/adhan_normal.mp3';
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.play();
    } catch (_) {}
  }

  Future<void> stopAdhan() async => await _audioPlayer.stop();
  void startPrayerTimeCheck({required Map<String, DateTime> prayerTimes}) {}
  void stopPrayerTimeCheck() => _checkTimer?.cancel();

  Future<void> showWelcomeNotification() async {
    try {
      await initialize();
      const adhkar = [
        'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
        'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
        'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
        'رَبِّ اغْفِرْ لِي وَارْحَمْنِي وَاهْدِنِي وَارْزُقْنِي',
        'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ',
        'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
      ];
      final dhikrIndex = DateTime.now().millisecondsSinceEpoch % adhkar.length;
      await _notificationManager.show(
        100,
        '🌙 مرحباً بك في تطبيق إسلامي',
        adhkar[dhikrIndex],
      );
    } catch (_) {}
  }

  void dispose() {
    _checkTimer?.cancel();
    _audioPlayer.dispose();
  }
}
