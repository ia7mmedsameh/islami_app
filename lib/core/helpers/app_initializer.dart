import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/core/data/azkar_list.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/services/adhan_service.dart';
import 'package:islami_app/features/prayer_times/data/api/azkar_api_service.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class AppInitializer {
  static RadioAudioHandler? audioHandler;

  static Future<void> initialize() async {
    await _setupDependencies();
    await _initializeHive();
    await _setPreferredOrientations();
    await _initializeAudioService();
    await _initializeAdhanService();
    await _loadAzkar();
    await _autoSchedulePrayerTimes();
  }

  static Future<void> _loadAzkar() async {
    try {
      final azkarService = getIt<AzkarApiService>();
      await AzkarList.loadAzkar(azkarService);
    } catch (_) {}
  }

  static Future<void> _setupDependencies() async => await setupGetIt();
  static Future<void> _initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox(kOnboardingBoxName);
    await Hive.openBox(kSurahsBoxName);
    await Hive.openBox(kAhadithBoxName);
  }

  static Future<void> _setPreferredOrientations() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

  static Future<void> _initializeAudioService() async {
    try {
      audioHandler = await AudioService.init(
        builder: () => getIt<RadioAudioHandler>(),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'islami_app.audio',
          androidNotificationChannelName: 'تشغيل الصوت',
          androidNotificationChannelDescription:
              'تشغيل القرآن والراديو في الخلفية',
          androidNotificationIcon: 'mipmap/ic_stat_notification',
          androidNotificationOngoing: false,
          androidStopForegroundOnPause: true,
          androidShowNotificationBadge: true,
          androidResumeOnClick: true,
        ),
      );
    } catch (_) {}
  }

  static Future<void> _initializeAdhanService() async =>
      await getIt<AdhanService>().initialize();

  static Future<void> _autoSchedulePrayerTimes() async {
    try {
      // التحقق من أن المستخدم قد شاهد الـ onboarding قبل طلب مواقيت الصلاة
      final onboardingBox = Hive.box(kOnboardingBoxName);
      final hasSeenOnboarding = onboardingBox.get(
        kOnboardingSeenKey,
        defaultValue: false,
      );

      if (!hasSeenOnboarding) {
        // لم يشاهد الـ onboarding بعد، لا نطلب الموقع
        return;
      }

      await _requestPermissions();
      await Future.delayed(const Duration(seconds: 1));
      await _showWelcomeNotification();
      final cubit = getIt<PrayerTimesCubit>();
      await cubit.getPrayerTimes();
    } catch (_) {}
  }

  static Future<void> _requestPermissions() async {
    // لا نطلب إذن الإشعارات أو الموقع هنا - يتم طلبهم في الـ onboarding
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  static Future<void> _showWelcomeNotification() async {
    final box = await Hive.openBox('app_settings');
    final isFirstLaunch = box.get('is_first_launch', defaultValue: true);
    if (isFirstLaunch) {
      final adhanService = getIt<AdhanService>();
      await adhanService.showWelcomeNotification();
      await box.put('is_first_launch', false);
    }
  }
}
