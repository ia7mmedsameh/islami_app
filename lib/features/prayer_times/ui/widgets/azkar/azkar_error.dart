import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class AzkarError extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onClose;

  const AzkarError({
    super.key,
    required this.errorMessage,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red.shade400),
            SizedBox(height: 20.h),
            Text(
              'حدث خطأ',
              style: AppTextStyles.font16WhiteBold.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              errorMessage,
              style: AppTextStyles.font16WhiteBold.copyWith(
                color: Colors.grey.shade300,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: onClose,
              icon: Icon(Icons.close, size: 20.sp),
              label: const Text('إغلاق'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainGold,
                foregroundColor: ColorsManager.black,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
