import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';

PageViewModel pageViewModelNotification() {
  return PageViewModel(
    decoration: const PageDecoration(contentMargin: EdgeInsets.zero),
    titleWidget: const SizedBox.shrink(),
    bodyWidget: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const IslamiLogoAndMosque(),
        verticalSpace(40),
        Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: ColorsManager.mainGold.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_active,
            size: 80.sp,
            color: ColorsManager.mainGold,
          ),
        ),
        verticalSpace(30),
        Text(
          'الإشعارات',
          style: AppTextStyles.font24GoldBold,
          textAlign: TextAlign.center,
        ),
        verticalSpace(20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'نستخدم الإشعارات لتذكيرك بالأذكار والتذكير بالصلاة على النبي ﷺ، ويمكنك التحكم في هذه التنبيهات أو إيقافها في أي وقت من الإعدادات.',
            style: AppTextStyles.font16WhiteBold,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
