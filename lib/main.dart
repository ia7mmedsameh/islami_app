import 'package:flutter/material.dart';
import 'package:islami_app/core/helpers/app_initializer.dart';
import 'package:islami_app/core/routing/app_router.dart';
import 'package:islami_app/islami_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();
  runApp(IslamiApp(appRouter: AppRouter()));
}
