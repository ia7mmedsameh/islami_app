import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class PrayerTimeItem extends StatelessWidget {
  final String name;
  final String time;
  final bool isNext;

  const PrayerTimeItem({
    super.key,
    required this.name,
    required this.time,
    this.isNext = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isNext ? 16.h : 12.h,
        horizontal: isNext ? 12.w : 8.w,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: isNext
            ? Border.all(color: ColorsManager.mainGold, width: 2)
            : null,
      ),
      child: Column(
        children: [
          Text(
            name,
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: isNext ? ColorsManager.mainGold : Colors.white,
              fontSize: isNext ? 14.sp : 12.sp,
              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            time,
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: ColorsManager.mainGold,
              fontSize: isNext ? 14.sp : 12.sp,
              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
