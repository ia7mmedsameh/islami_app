import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_control_button.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_play_button.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_volume_slider.dart';

class AudioControlsRow extends StatelessWidget {
  final bool isPlaying;
  final double volume;
  final AudioCubit audioCubit;
  final Function(int)? onNavigateToSurah;
  final VoidCallback onRepeatPressed;
  final bool showVolumeSlider;
  final VoidCallback onVolumeToggle;

  const AudioControlsRow({
    super.key,
    required this.isPlaying,
    required this.volume,
    required this.audioCubit,
    this.onNavigateToSurah,
    required this.onRepeatPressed,
    required this.showVolumeSlider,
    required this.onVolumeToggle,
  });

  IconData _getRepeatIcon() => switch (audioCubit.repeatMode) {
    RepeatMode.off => Icons.repeat_rounded,
    RepeatMode.one => Icons.repeat_one_rounded,
    RepeatMode.all => Icons.repeat_on_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AudioControlButton(
          icon: Icons.skip_previous_rounded,
          onPressed: () =>
              audioCubit.playPrevious(onNavigate: onNavigateToSurah),
          isActive: false,
          size: 28.sp,
        ),
        SizedBox(width: 12.w),
        AudioControlButton(
          icon: _getRepeatIcon(),
          onPressed: onRepeatPressed,
          isActive: audioCubit.isRepeatEnabled,
          size: 24.sp,
        ),
        SizedBox(width: 16.w),
        AudioPlayButton(
          isPlaying: isPlaying,
          onTap: () => isPlaying ? audioCubit.pause() : audioCubit.resume(),
        ),
        SizedBox(width: 16.w),
        AudioControlButton(
          icon: getVolumeIcon(volume),
          onPressed: onVolumeToggle,
          isActive: showVolumeSlider,
          size: 24.sp,
        ),
        SizedBox(width: 12.w),
        AudioControlButton(
          icon: Icons.skip_next_rounded,
          onPressed: () => audioCubit.playNext(onNavigate: onNavigateToSurah),
          isActive: false,
          size: 28.sp,
        ),
      ],
    );
  }
}
