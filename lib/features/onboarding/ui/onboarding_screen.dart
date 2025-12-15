import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/helpers/extensions.dart';
import 'package:islami_app/core/routing/routes.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/onboarding/ui/widgets/onboarding_intro_config.dart';
import 'package:islami_app/features/onboarding/ui/widgets/onboarding_pages_builder.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _showNotificationPage = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAndroidVersion();
  }

  Future<void> _checkAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      _showNotificationPage = androidInfo.version.sdkInt >= 33;
    } else {
      _showNotificationPage = true;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _handleOnboardingComplete() async {
    Hive.box(kOnboardingBoxName).put(kOnboardingSeenKey, true);
    if (mounted) context.pushReplacementNamed(Routes.navigationScreen);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CustomScaffold(
        body: Center(
          child: CircularProgressIndicator(color: ColorsManager.mainGold),
        ),
      );
    }

    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: IntroductionScreen(
            pages: OnboardingPagesBuilder.build(
              showNotificationPage: _showNotificationPage,
            ),
            onDone: _handleOnboardingComplete,
            dotsDecorator: OnboardingIntroConfig.dotsDecorator,
            globalBackgroundColor: ColorsManager.black,
            done: OnboardingIntroConfig.doneButton,
            next: OnboardingIntroConfig.nextButton,
            back: OnboardingIntroConfig.backButton,
            showSkipButton: false,
            showBackButton: true,
          ),
        ),
      ),
    );
  }
}
