import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/routing/app_router.dart';
import 'package:islami_app/islami_app.dart';

void main() async {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(kOnboardingBoxName);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(IslamiApp(appRouter: AppRouter()));
}
