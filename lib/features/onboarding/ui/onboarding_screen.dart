import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/helpers/extensions.dart';
import 'package:islami_app/core/routing/routes.dart';
import 'package:islami_app/core/services/location_permission_service.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/onboarding/ui/widgets/location_page_view_model.dart';
import 'package:islami_app/features/onboarding/ui/widgets/page_views_model.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _handleOnboardingComplete(BuildContext context) async {
    // طلب إذن الموقع بعد شرح السبب
    final result = await LocationPermissionService.requestLocationPermission();

    // عرض رسالة للمستخدم في حالة الرفض
    if (!result.granted && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.message,
            style: const TextStyle(fontFamily: 'Janna-LT'),
          ),
          backgroundColor: ColorsManager.mainGold,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    // حفظ حالة الـ onboarding والانتقال للتطبيق
    final box = Hive.box(kOnboardingBoxName);
    box.put(kOnboardingSeenKey, true);

    if (context.mounted) {
      context.pushReplacementNamed(Routes.navigationScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: IntroductionScreen(
            pages: [
              pageViewModelOne(),
              pageViewModelTwo(),
              pageViewModelThree(),
              pageViewModelFour(),
              pageViewModelLocation(), // صفحة الموقع قبل الانتهاء
            ],
            onDone: () => _handleOnboardingComplete(context),

            dotsDecorator: const DotsDecorator(
              size: Size(6, 6),
              spacing: EdgeInsets.symmetric(horizontal: 3),
              color: ColorsManager.gray,
              activeSize: Size(14, 6),
              activeColor: ColorsManager.goldLighter,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),

            globalBackgroundColor: ColorsManager.black,
            done: Text("ابدأ الاستخدام", style: AppTextStyles.font16GoldBold),
            next: Text('التالي', style: AppTextStyles.font16GoldBold),
            showSkipButton: false, // إزالة زر التخطي لضمان رؤية صفحة الموقع
            showBackButton: true,
            back: Text('الرجوع', style: AppTextStyles.font16GoldBold),
          ),
        ),
      ),
    );
  }
}
