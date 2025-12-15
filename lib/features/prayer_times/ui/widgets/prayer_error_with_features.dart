import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/background_for_pray_time_screen.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_content/prayer_azkar_section.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_content/prayer_settings_button.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_location_error.dart';
import 'package:islami_app/features/sebha/ui/widgets/color_linear_for_sebha_screen.dart';

class PrayerErrorWithFeatures extends StatelessWidget {
  final String message;

  const PrayerErrorWithFeatures({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Backgroungforpraytimescreen(),
        const ColorLinearForSebhaScreen(),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: const IslamiLogoAndMosque(),
                ),
                PrayerLocationError(message: message),
                SizedBox(height: 24.h),
                const PrayerSettingsButton(),
                SizedBox(height: 24.h),
                const PrayerAzkarSection(),
                verticalSpace(25),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
