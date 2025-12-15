import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class OnboardingIntroConfig {
  static DotsDecorator get dotsDecorator => const DotsDecorator(
    size: Size(5, 5),
    spacing: EdgeInsets.symmetric(horizontal: 2),
    color: ColorsManager.gray,
    activeSize: Size(12, 5),
    activeColor: ColorsManager.goldLighter,
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    ),
  );

  static Widget get doneButton =>
      Text("ابدأ الاستخدام", style: AppTextStyles.font16GoldBold);

  static Widget get nextButton =>
      Text('التالي', style: AppTextStyles.font16GoldBold);

  static Widget get backButton =>
      Text('الرجوع', style: AppTextStyles.font16GoldBold);
}
