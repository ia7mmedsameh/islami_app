import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_control_button.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_play_button.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_volume_slider.dart';

class RadioPlayerButtons extends StatelessWidget {
  final bool isPlaying;
  final double volume;
  final RadioCubit cubit;
  final List<dynamic>? radios;
  final String radioUrl;
  final bool showVolumeSlider;
  final VoidCallback onVolumeToggle;

  const RadioPlayerButtons({
    super.key,
    required this.isPlaying,
    required this.volume,
    required this.cubit,
    this.radios,
    required this.radioUrl,
    required this.showVolumeSlider,
    required this.onVolumeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (radios != null)
              AudioControlButton(
                icon: Icons.skip_previous_rounded,
                onPressed: () => cubit.playPrevious(radios!, radioUrl),
                isActive: false,
                size: 28.sp,
              ),
            if (radios != null) SizedBox(width: 16.w),
            AudioPlayButton(
              isPlaying: isPlaying,
              onTap: () => isPlaying ? cubit.pause() : cubit.resume(),
            ),
            if (radios != null) SizedBox(width: 16.w),
            if (radios != null)
              AudioControlButton(
                icon: Icons.skip_next_rounded,
                onPressed: () => cubit.playNext(radios!, radioUrl),
                isActive: false,
                size: 28.sp,
              ),
            SizedBox(width: 16.w),
            AudioControlButton(
              icon: getVolumeIcon(volume),
              onPressed: onVolumeToggle,
              isActive: showVolumeSlider,
              size: 24.sp,
            ),
          ],
        ),
        if (showVolumeSlider) ...[
          SizedBox(height: 12.h),
          AudioVolumeSlider(volume: volume, onChanged: cubit.setVolume),
        ],
      ],
    );
  }
}
