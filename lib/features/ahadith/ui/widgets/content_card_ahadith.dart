import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';
import 'package:islami_app/features/ahadith/ui/widgets/bloc_builder_ahadith.dart';

class ContentCardAhadith extends StatelessWidget {
  final Data data;
  final int index;
  const ContentCardAhadith({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20.h),
      child: Card(
        color: const Color(0xFFD9B47E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 6,
        child: Stack(
          children: [
            Image.asset(
              Assets.imagesMoshaf,
              color: const Color.fromARGB(36, 32, 32, 32),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                Assets.imagesMosque2,
                color: const Color.fromARGB(47, 32, 32, 32),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.w),
              child: BlocBuilderAhadith(index: index),
            ),
            
          ],
        ),
      ),
    );
  }
}
