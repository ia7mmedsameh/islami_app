import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';

class HadithDetailsBody extends StatelessWidget {
  final Data hadith;

  const HadithDetailsBody({super.key, required this.hadith});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(Assets.imagesMaskGroup, width: 95.w, height: 95.h),
              Flexible(
                child: Text(
                  "الحديث رقم ${hadith.hadithNumber ?? ''}",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font20WhiteBold2.copyWith(
                    color: ColorsManager.mainGold,
                    fontSize: 22.sp,
                  ),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.asset(
                  Assets.imagesMaskGroup,
                  width: 95.w,
                  height: 95.h,
                ),
              ),
            ],
          ),
          verticalSpace(30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.mainGold, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    Assets.imagesMosque2,
                    color: const Color.fromARGB(47, 32, 32, 32),
                  ),
                ),
                Center(
                  child: Text(
                    hadith.hadithArabic ?? "حدث خطأ غير متوقع",
                    style: AppTextStyles.font20WhiteBold2.copyWith(
                      color: ColorsManager.mainGold,
                      fontSize: 21.sp,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
