import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class PrayerLocationError extends StatelessWidget {
  final String message;

  const PrayerLocationError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.mainGold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            message.contains('صلاحية')
                ? Icons.location_off
                : Icons.error_outline,
            size: 48.sp,
            color: ColorsManager.mainGold,
          ),
          SizedBox(height: 12.h),
          Text(
            'مواقيت الصلاة',
            style: TextStyle(
              color: ColorsManager.mainGold,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.5),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<PrayerTimesCubit>().getPrayerTimes(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainGold,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            ),
            child: Text(
              'إعادة المحاولة',
              style: TextStyle(color: ColorsManager.black, fontSize: 14.sp),
            ),
          ),
          if (message.contains('صلاحية')) ...[
            SizedBox(height: 12.h),
            OutlinedButton(
              onPressed: () => openAppSettings(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorsManager.mainGold),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              ),
              child: Text(
                'إعدادات التطبيق',
                style: TextStyle(
                  color: ColorsManager.mainGold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
