import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class RadioPlayerHeader extends StatelessWidget {
  final String radioName;

  const RadioPlayerHeader({super.key, required this.radioName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorsManager.mainGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsManager.mainGold.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.radio_rounded, color: ColorsManager.mainGold, size: 18.sp),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              radioName,
              style: AppTextStyles.font16WhiteBold.copyWith(
                color: ColorsManager.mainGold,
                fontSize: 14.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
