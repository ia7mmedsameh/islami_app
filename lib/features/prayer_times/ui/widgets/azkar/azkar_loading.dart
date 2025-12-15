import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AzkarLoading extends StatelessWidget {
  const AzkarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/gifs/trail_loading.json',
        width: 150.w,
        height: 150.h,
      ),
    );
  }
}
