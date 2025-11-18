import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';

class RadioPlayerControls extends StatelessWidget {
  final String radioName;
  final bool isPlaying;
  final double volume;
  final RadioCubit cubit;

  const RadioPlayerControls({
    super.key,
    required this.radioName,
    required this.isPlaying,
    required this.volume,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(radioName, style: AppTextStyles.font16WhiteBold),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => isPlaying ? cubit.pause() : cubit.resume(),
            ),
            IconButton(
              icon: Icon(_getVolumeIcon(volume), color: Colors.white),
              onPressed: () => _showVolumeSheet(context),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getVolumeIcon(double volume) {
    if (volume == 0) return Icons.volume_off;
    if (volume < 0.3) return Icons.volume_mute;
    if (volume < 0.7) return Icons.volume_down;
    return Icons.volume_up;
  }

  void _showVolumeSheet(BuildContext context) {
    double currentVolume = volume;
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.black,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) {
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
                  onChanged: (v) {
                    setState(() => currentVolume = v);
                    cubit.setVolume(v);
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

