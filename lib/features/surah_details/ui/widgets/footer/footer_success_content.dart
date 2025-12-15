import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/ui/surah_details_screen.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_progress_slider.dart';
import 'package:islami_app/features/surah_details/ui/widgets/footer/footer_surah_badge.dart';

class FooterSuccessContent extends StatelessWidget {
  final String surahName;
  final AudioCubit audioCubit;
  final bool isPlaying;
  final double volume;
  final Duration position;
  final Duration total;

  const FooterSuccessContent({
    super.key,
    required this.surahName,
    required this.audioCubit,
    required this.isPlaying,
    required this.volume,
    required this.position,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FooterSurahBadge(surahName: surahName),
        SizedBox(height: 12.h),
        AudioProgressSlider(
          position: position,
          total: total,
          audioCubit: audioCubit,
        ),
        AudioControls(
          isPlaying: isPlaying,
          volume: volume,
          audioCubit: audioCubit,
          onNavigateToSurah: (surahNumber) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SurahDetailsScreen(surahNumber: surahNumber),
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        Text(
          'التلاوات الصوتية مقدمة عبر AlQuran Cloud API',
          style: TextStyle(color: ColorsManager.gray, fontSize: 10.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
