import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioControls extends StatelessWidget {
  final bool isPlaying;
  final double volume;
  final AudioCubit audioCubit;

  const AudioControls({
    super.key,
    required this.isPlaying,
    required this.volume,
    required this.audioCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => isPlaying ? audioCubit.pause() : audioCubit.resume(),
        ),
        IconButton(
          icon: Icon(_getVolumeIcon(volume), color: Colors.white),
          onPressed: () => _showVolumeSheet(context),
        ),
      ],
    );
  }

  IconData _getVolumeIcon(double volume) {
    if (volume == 0) return Icons.volume_off;
    if (volume <= 0.3) return Icons.volume_mute;
    if (volume <= 0.7) return Icons.volume_down;
    return Icons.volume_up;
  }

  void _showVolumeSheet(BuildContext context) {
    double currentVolume = volume;
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("تحكم في الصوت", style: AppTextStyles.font16WhiteBold),
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
  }
}
