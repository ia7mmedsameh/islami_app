import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../core/helpers/spacing.dart';

class SurahsShimmerLoading extends StatelessWidget {
  const SurahsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          baseColor: ColorsManager.black,
          highlightColor: Colors.white,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 20.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: ColorsManager.black,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        verticalSpace(10),
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, i) => const ShimmerItem(),
          separatorBuilder: (context, i) => const Divider(
            thickness: 1,
            color: Colors.white,
            indent: 30,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: ColorsManager.black,
      highlightColor: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(60.r),
          ),
        ),
        title: Container(
          height: 20.h,
          width: 120.w,
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        subtitle: Container(
          height: 15.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        trailing: Container(
          height: 20.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }
}
