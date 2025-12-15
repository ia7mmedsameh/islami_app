import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_state.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_error_with_features.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_times_content.dart';
import 'package:lottie/lottie.dart';

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
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
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
          error: (message) => PrayerErrorWithFeatures(message: message),
        );
      },
    );
  }
}
