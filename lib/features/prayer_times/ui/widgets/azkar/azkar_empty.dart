import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class AzkarEmpty extends StatelessWidget {
  const AzkarEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 64.sp, color: ColorsManager.mainGold),
          SizedBox(height: 16.h),
          Text(
            'لا توجد أذكار متاحة',
            style: AppTextStyles.font16WhiteBold.copyWith(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
