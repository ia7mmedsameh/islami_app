import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/theming/styles.dart';

class SebhaRosaryWidget extends StatelessWidget {
  final int counter;
  final VoidCallback onTap;

  const SebhaRosaryWidget({
    super.key,
    required this.counter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxWidth.clamp(250.0, 400.0);
          return SizedBox(
            width: size.w,
            height: size.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Assets.imagesSebha,
                  width: size.w,
                  height: size.h,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: size.h * 0.47,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'سبحان الله',
                        style: AppTextStyles.font36WhiteBold.copyWith(
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '$counter',
                        style: AppTextStyles.font36WhiteBold.copyWith(
                          fontSize: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
