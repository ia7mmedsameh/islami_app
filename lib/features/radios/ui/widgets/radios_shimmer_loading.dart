import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:shimmer/shimmer.dart';

class RadiosShimmerLoading extends StatelessWidget {
  const RadiosShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: 8,
      itemBuilder: (context, i) => const RadioShimmerItem(),
      separatorBuilder: (_, __) => Divider(
        color: Colors.white.withOpacity(.2),
        indent: 20.w,
        endIndent: 20.w,
      ),
    );
  }
}

class RadioShimmerItem extends StatelessWidget {
  const RadioShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: ColorsManager.black,
      highlightColor: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        title: Container(
          height: 20.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        trailing: Container(
          height: 24.h,
          width: 24.w,
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
