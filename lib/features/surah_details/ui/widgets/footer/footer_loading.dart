import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';

class FooterLoading extends StatelessWidget {
  const FooterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: const Center(
        child: CircularProgressIndicator(color: ColorsManager.mainGold),
      ),
    );
  }
}
