import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/surah_details/data/models/sura_details_response_model.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_progress_slider.dart';

class FooterQuranPlayer extends StatelessWidget {
  final DetailsSura detailsSura;

  const FooterQuranPlayer({super.key, required this.detailsSura});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AudioCubit>()
            ..setAudioSource(detailsSura.number ?? 1, detailsSura.name ?? ''),
      child: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          final audioCubit = context.read<AudioCubit>();
          return Container(
            color: ColorsManager.black,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: state.maybeWhen(
              loading: () =>  SizedBox(
                height: 60.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainGold,
                  ),
                ),
              ),
              success: (isPlaying, volume, position, total) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AudioProgressSlider(
                    position: position,
                    total: total,
                    audioCubit: audioCubit,
                  ),
                  AudioControls(
                    isPlaying: isPlaying,
                    volume: volume,
                    audioCubit: audioCubit,
                  ),
                ],
              ),
              error: (_) => Center(
                child: Text(
                  'حدث خطأ أثناء تشغيل ( ${detailsSura.name} )',
                  style: AppTextStyles.font16WhiteBold.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
