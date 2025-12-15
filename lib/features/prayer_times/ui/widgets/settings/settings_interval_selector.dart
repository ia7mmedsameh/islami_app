import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class SettingsIntervalSelector extends StatelessWidget {
  final int selectedInterval;
  final List<int> intervals;
  final ValueChanged<int> onChanged;

  const SettingsIntervalSelector({
    super.key,
    required this.selectedInterval,
    required this.intervals,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التذكير كل',
          style: AppTextStyles.font16WhiteBold.copyWith(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: intervals.map((hours) {
            final isSelected = selectedInterval == hours;
            return GestureDetector(
              onTap: () => onChanged(hours),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorsManager.mainGold
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected
                        ? ColorsManager.mainGold
                        : Colors.grey.shade600,
                  ),
                ),
                child: Text(
                  '$hours ${hours == 1 ? 'ساعة' : 'ساعات'}',
                  style: AppTextStyles.font16WhiteBold.copyWith(
                    color: isSelected ? ColorsManager.black : Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
