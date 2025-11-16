import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/surah_details/data/models/sura_details_response_model.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';

class FooterQuranPlayer extends StatelessWidget {
  final DetailsSura detailsSura;
  const FooterQuranPlayer({super.key, required this.detailsSura});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
create: (_) => getIt<AudioCubit>()
  ..setAudioSource(
    detailsSura.number ?? 1,
    detailsSura.name ?? '',
  ),
      child: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          final audioCubit = context.read<AudioCubit>();
          return Container(
            color: ColorsManager.black,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: state.maybeWhen(
              loading: () => const SizedBox(
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainGold,
                  ),
                ),
              ),
              success: (isPlaying, volume, position, total) {
                return setupSuccess(
                  total,
                  position,
                  audioCubit,
                  isPlaying,
                  volume,
                  context,
                );
              },
              error: (message) => setupError(),
              orElse: () => const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  Center setupError() {
    return Center(
      child: Text(
        'حدث خطأ أثناء تشغيل ( ${detailsSura.name} )',
        style: AppTextStyles.font16WhiteBold.copyWith(color: Colors.red),
      ),
    );
  }

  Column setupSuccess(
    Duration total,
    Duration position,
    AudioCubit audioCubit,
    bool isPlaying,
    double volume,
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: 0,
          max: total.inMilliseconds.toDouble().clamp(1, double.infinity),
          value: position.inMilliseconds
              .clamp(0, total.inMilliseconds)
              .toDouble(),
          onChanged: (value) =>
              audioCubit.seek(Duration(milliseconds: value.toInt())),
          activeColor: ColorsManager.mainGold,
          inactiveColor: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(position),
              style: AppTextStyles.font14WhiteBold,
            ),
            Text(_formatDuration(total), style: AppTextStyles.font14WhiteBold),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                if (isPlaying) {
                  audioCubit.pause();
                } else {
                  audioCubit.resume();
                }
              },
            ),
            IconButton(
              icon: Icon(
                volume == 0
                    ? Icons.volume_off
                    : volume <= 0.3
                    ? Icons.volume_mute
                    : volume <= 0.7
                    ? Icons.volume_down
                    : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: () {
                double currentVolume = volume;
                showModalBottomSheet(
                  context: context,
                  backgroundColor: ColorsManager.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (_) => StatefulBuilder(
                    builder: (context, setModalState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "تحكم في الصوت",
                              style: AppTextStyles.font16WhiteBold,
                            ),
                            Slider(
                              min: 0,
                              max: 1,
                              value: currentVolume,
                              onChanged: (value) {
                                setModalState(() => currentVolume = value);
                                audioCubit.setVolume(value);
                              },
                              activeColor: ColorsManager.mainGold,
                              inactiveColor: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }
}
