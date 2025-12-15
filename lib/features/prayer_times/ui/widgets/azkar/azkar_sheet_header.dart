import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class AzkarSheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const AzkarSheetHeader({
    super.key,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.mainGold,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: ColorsManager.black,
              fontSize: 18.sp,
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, color: ColorsManager.black, size: 24.sp),
          ),
        ],
      ),
    );
  }
}
