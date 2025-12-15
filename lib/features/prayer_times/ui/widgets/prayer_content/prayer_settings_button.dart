import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_settings_sheet.dart';

class PrayerSettingsButton extends StatelessWidget {
  const PrayerSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          final cubit = context.read<PrayerTimesCubit>();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (sheetContext) => BlocProvider.value(
              value: cubit,
              child: const PrayerSettingsSheet(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorsManager.mainGold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorsManager.mainGold.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, color: ColorsManager.mainGold, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إعدادات التنبيهات',
                      style: AppTextStyles.font16WhiteBold.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'الأذان والصلاة على النبي',
                      style: AppTextStyles.font16WhiteBold.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.mainGold,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
