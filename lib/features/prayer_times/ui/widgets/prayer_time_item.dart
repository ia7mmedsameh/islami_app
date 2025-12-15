import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class PrayerTimeItem extends StatelessWidget {
  final String name;
  final String time;

  const PrayerTimeItem({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            time,
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: ColorsManager.mainGold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
