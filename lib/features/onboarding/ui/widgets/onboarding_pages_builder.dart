import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/features/onboarding/ui/widgets/location_permission_page.dart';
import 'package:islami_app/features/onboarding/ui/widgets/notification_permission_page.dart';
import 'package:islami_app/features/onboarding/ui/widgets/page_views_model.dart';

class OnboardingPagesBuilder {
  static List<PageViewModel> build({required bool showNotificationPage}) {
    final pages = [
      pageViewModelOne(),
      pageViewModelTwo(),
      pageViewModelThree(),
      pageViewModelFour(),
    ];

    if (showNotificationPage) {
      pages.add(_buildNotificationPage());
    }

    pages.add(_buildLocationPage());
    return pages;
  }

  static PageViewModel _buildNotificationPage() {
    return PageViewModel(
      decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
      titleWidget: const SizedBox.shrink(),
      bodyWidget: const NotificationPermissionPage(),
      useScrollView: false,
    );
  }

  static PageViewModel _buildLocationPage() {
    return PageViewModel(
      decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
      titleWidget: const SizedBox.shrink(),
      bodyWidget: const LocationPermissionPage(),
      useScrollView: false,
    );
  }
}
