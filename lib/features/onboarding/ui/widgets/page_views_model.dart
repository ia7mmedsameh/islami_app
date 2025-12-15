import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/onboarding/ui/widgets/onboarding_description.dart';
import 'package:islami_app/features/onboarding/ui/widgets/sized_box_for_image_onboarding.dart';

PageViewModel pageViewModelOne() {
  return PageViewModel(
    decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
    titleWidget: const SizedBox.shrink(),
    bodyWidget: Column(
      children: [
        const IslamiLogoAndMosque(),
        verticalSpace(40),
        const SizedBoxForImageOnboarding(assetsImage: Assets.imagesKabba),
        verticalSpace(20),
        const OnboardingDescription(
          textIdentification: 'مرحبًا بك في إسلامي',
          textExplain:
              'رفيقك اليومي للقرآن والأذكار ومواقيت الصلاة والأحاديث النبوية',
        ),
      ],
    ),
  );
}

PageViewModel pageViewModelTwo() {
  return PageViewModel(
    decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
    titleWidget: const SizedBox.shrink(),
    bodyWidget: Column(
      children: [
        const IslamiLogoAndMosque(),
        verticalSpace(40),
        const SizedBoxForImageOnboarding(assetsImage: Assets.imagesMoshaf),
        verticalSpace(20),
        const OnboardingDescription(
          textIdentification: 'القرآن الكريم',
          textExplain: 'اقرأ واستمع للقرآن الكريم',
        ),
      ],
    ),
  );
}

PageViewModel pageViewModelThree() {
  return PageViewModel(
    decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
    titleWidget: const SizedBox.shrink(),
    bodyWidget: Column(
      children: [
        const IslamiLogoAndMosque(),
        verticalSpace(40),
        const SizedBoxForImageOnboarding(assetsImage: Assets.imagesBearish),
        verticalSpace(20),
        const OnboardingDescription(
          textIdentification: 'السبحة',
          textExplain: 'سبّح واذكر الله مع عداد التسبيح وأذكار متنوعة',
        ),
      ],
    ),
  );
}

PageViewModel pageViewModelFour() {
  return PageViewModel(
    decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
    titleWidget: const SizedBox.shrink(),
    bodyWidget: Column(
      children: [
        const IslamiLogoAndMosque(),
        verticalSpace(40),
        const SizedBoxForImageOnboarding(assetsImage: Assets.imagesRadio),
        verticalSpace(20),
        const OnboardingDescription(
          textIdentification: 'إذاعات القرآن الكريم',
          textExplain: 'استمع إلى مجموعة كبيرة من إذاعات القرآن الكريم من مختلف أنحاء العالم',
        ),
      ],
    ),
  );
}
