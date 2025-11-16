
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';
import 'package:lottie/lottie.dart';

class DetailsAhadith extends StatelessWidget {
  const DetailsAhadith({
    super.key,
    required this.hadith,
  });

  final Data hadith;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                Assets.imagesMaskGroup,
                width: 90.w,
                height: 90.h,
                color: ColorsManager.black,
              ),
              Text(
                "الحديث رقم ${hadith.hadithNumber ?? 'حدث خطأ غير متوقع'}",
                style: AppTextStyles.font20BlackBold,
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.asset(
                  Assets.imagesMaskGroup,
                  width: 90.w,
                  height: 90.h,
                  color: ColorsManager.black,
                ),
              ),
            ],
          ),
          verticalSpace(20),
          Text(
            hadith.hadithArabic ?? "حدث خطأ غير متوقع",
            textAlign: TextAlign.center,
            style: AppTextStyles.font18Blacksemibold,
          ),
        ],
      ),
    );
  }
}

Widget setupLoading() {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Center(
      child: Lottie.asset(
        Assets.gifsTrailLoading,
        fit: BoxFit.contain,
        repeat: true,
        width: 170.w,
        height: 170.h,
        delegates: LottieDelegates(
          values: [
            ValueDelegate.color(
              const ['**'],
              value: ColorsManager.black,
            ),
          ],
        ),
      ),
    ),
  );
}