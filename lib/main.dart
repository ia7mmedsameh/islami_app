import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/routing/app_router.dart';
import 'package:islami_app/islami_app.dart';

import 'package:audio_service/audio_service.dart';
import 'package:islami_app/features/radios/logic/audio_handler/radio_audio_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DI
  await setupGetIt();

  // Hive
  await Hive.initFlutter();
  await Hive.openBox(kOnboardingBoxName);

  // Lock Orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 🔊 Initialize AudioService ONE TIME ONLY
  final handler = await AudioService.init(
    builder: () => RadioAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'islami_app.audio',
      androidNotificationChannelName: 'تشغيل الصوت',
      androidNotificationChannelDescription: 'تشغيل القرآن والراديو في الخلفية',
      androidNotificationIcon: 'mipmap/launcher_icon',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidShowNotificationBadge: true,
      androidResumeOnClick: true,
    ),
  );

  // Register handler globally for Radio + Quran
  getIt.registerSingleton<RadioAudioHandler>(handler);

  runApp(IslamiApp(appRouter: AppRouter()));
}
