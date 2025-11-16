import 'package:flutter/material.dart';
import 'package:islami_app/core/routing/routes.dart';
import 'package:islami_app/features/navigation/ui/navigation_screen.dart';
import 'package:islami_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:islami_app/features/splash_screen/ui/splash_screen.dart';
import 'package:islami_app/features/surah_details/ui/surah_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      case Routes.surahDetailsScreen:
        return MaterialPageRoute(
          builder: (_) =>
              SurahDetailsScreen(surahNumber: settings.arguments as int),
        );
      default:
        return null;
    }
  }
}
