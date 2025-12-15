import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class NextPrayerSection extends StatelessWidget {
  final String nextPrayer;
  final String timeRemaining;

  const NextPrayerSection({
    super.key,
    required this.nextPrayer,
    required this.timeRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الصلاة القادمة: $nextPrayer',
                style: AppTextStyles.font16WhiteBold.copyWith(
                  color: ColorsManager.black,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'الوقت المتبقي: $timeRemaining',
                style: AppTextStyles.font16WhiteBold.copyWith(
                  color: ColorsManager.black.withValues(alpha: 0.7),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Icon(Icons.access_time, color: ColorsManager.black, size: 24.sp),
        ],
      ),
    );
  }
}
