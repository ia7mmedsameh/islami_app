import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';

class AudioVolumeSlider extends StatelessWidget {
  final double volume;
  final ValueChanged<double> onChanged;

  const AudioVolumeSlider({
    super.key,
    required this.volume,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.volume_down_rounded,
            color: Colors.white.withValues(alpha: 0.6),
            size: 20.sp,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 3.h,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
                activeTrackColor: ColorsManager.mainGold,
                inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
                thumbColor: ColorsManager.mainGold,
                overlayColor: ColorsManager.mainGold.withValues(alpha: 0.2),
              ),
              child: Slider(value: volume, onChanged: onChanged),
            ),
          ),
          Icon(
            Icons.volume_up_rounded,
            color: Colors.white.withValues(alpha: 0.6),
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}

IconData getVolumeIcon(double volume) {
  if (volume == 0) return Icons.volume_off_rounded;
  if (volume <= 0.3) return Icons.volume_mute_rounded;
  if (volume <= 0.7) return Icons.volume_down_rounded;
  return Icons.volume_up_rounded;
}
