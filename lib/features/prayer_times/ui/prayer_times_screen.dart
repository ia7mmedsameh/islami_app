import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_state.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_times_content.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PrayerTimesCubit>()..getPrayerTimes(),
      child: const CustomScaffold(body: PrayerTimesBody()),
    );
  }
}

class PrayerTimesBody extends StatelessWidget {
  const PrayerTimesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => Center(
                child: Lottie.asset(
                  'assets/gifs/trail_loading.json',
                  width: 170.w,
                  height: 170.h,
                ),
              ),
              success: (data) => PrayerTimesContent(data: data),
              error: (message) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        message.contains('صلاحية')
                            ? Icons.location_off
                            : Icons.error_outline,
                        size: 64.sp,
                        color: ColorsManager.mainGold,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<PrayerTimesCubit>().getPrayerTimes(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainGold,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Text(
                          'إعادة المحاولة',
                          style: TextStyle(
                            color: ColorsManager.black,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
