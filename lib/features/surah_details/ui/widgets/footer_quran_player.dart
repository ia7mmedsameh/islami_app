import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/audio_manager/global_audio_state.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/surah_details/data/models/sura_details_response_model.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';
import 'package:islami_app/features/surah_details/ui/widgets/footer/footer_loading.dart';
import 'package:islami_app/features/surah_details/ui/widgets/footer/footer_error.dart';
import 'package:islami_app/features/surah_details/ui/widgets/footer/footer_success_content.dart';

class FooterQuranPlayer extends StatelessWidget {
  final DetailsSura detailsSura;

  const FooterQuranPlayer({super.key, required this.detailsSura});

  @override
  Widget build(BuildContext context) {
    final globalState = getIt<GlobalAudioManager>().state;
    final isSameSurahPlaying =
        globalState is PlayingQuran &&
        globalState.surahNumber == detailsSura.number;

    return BlocProvider(
      create: (_) {
        final cubit = getIt<AudioCubit>();
        isSameSurahPlaying
            ? cubit.connectToExistingPlayer()
            : cubit.setAudioSource(
                detailsSura.number ?? 1,
                detailsSura.name ?? '',
              );
        return cubit;
      },
      child: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          final audioCubit = context.read<AudioCubit>();
          return Container(
            color: ColorsManager.black,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: state.maybeWhen(
              loading: () => const FooterLoading(),
              success: (isPlaying, volume, position, total) =>
                  FooterSuccessContent(
                    surahName: detailsSura.name ?? '',
                    audioCubit: audioCubit,
                    isPlaying: isPlaying,
                    volume: volume,
                    position: position,
                    total: total,
                  ),
              error: (msg) => FooterError(message: msg),
              orElse: () => const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
