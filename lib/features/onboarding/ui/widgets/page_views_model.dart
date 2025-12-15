import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/onboarding/ui/widgets/onboarding_description.dart';
import 'package:islami_app/features/onboarding/ui/widgets/sized_box_for_image_onboarding.dart';

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
          textIdentification: 'إذاعة القرآن الكريم',
          textExplain:
              'يمكنك الاستماع إلى إذاعة القرآن الكريم من خلال التطبيق مجانًا وبكل سهولة',
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
          textIdentification: 'تسبيح',
          textExplain: 'سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى',
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
          textIdentification: 'قراءة القرآن',
          textExplain: 'اقرأ وربك الأكرم',
        ),
      ],
    ),
  );
}

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
          textIdentification: 'مرحبًا بك في تطبيق إسلامي',
          textExplain: 'سعيد باختيارك تطبيق يقرّبك إلى الله',
        ),
      ],
    ),
  );
}
