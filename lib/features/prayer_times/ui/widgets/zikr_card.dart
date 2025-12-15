import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/prayer_times/data/models/azkar_model.dart';

class ZikrCard extends StatelessWidget {
  final ZikrItem zikr;

  const ZikrCard({super.key, required this.zikr});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.mainGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.mainGold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            zikr.cleanContent,
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: Colors.white,
              fontSize: 16.sp,
              height: 1.8,
            ),
            textAlign: TextAlign.right,
          ),
          if (zikr.cleanCount.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildCountBadge(),
          ],
          if (zikr.cleanDescription.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              zikr.cleanDescription,
              style: AppTextStyles.font16WhiteBold.copyWith(
                color: Colors.grey.shade400,
                fontSize: 12.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorsManager.mainGold,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        'التكرار: ${zikr.cleanCount}',
        style: AppTextStyles.font16WhiteBold.copyWith(
          color: ColorsManager.black,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
