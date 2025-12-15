import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/styles.dart';

class SebhaHeaderText extends StatelessWidget {
  const SebhaHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
        style: AppTextStyles.font36WhiteBold.copyWith(fontSize: 28.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
