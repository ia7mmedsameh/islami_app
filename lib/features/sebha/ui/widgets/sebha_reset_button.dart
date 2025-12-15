import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/styles.dart';

class SebhaResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SebhaResetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          'تصفير عداد التسبيح',
          style: AppTextStyles.font24WhiteBold.copyWith(fontSize: 18.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
