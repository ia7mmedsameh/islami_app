import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class PrivacySectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const PrivacySectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.gray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.mainGold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ColorsManager.mainGold, size: 24.sp),
              SizedBox(width: 10.w),
              Expanded(child: Text(title, style: AppTextStyles.font16GoldBold)),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: AppTextStyles.font14WhiteBold.copyWith(
              fontWeight: FontWeight.normal,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
