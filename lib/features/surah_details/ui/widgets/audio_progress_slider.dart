import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';

class AudioProgressSlider extends StatelessWidget {
  final Duration position;
  final Duration total;
  final AudioCubit audioCubit;

  const AudioProgressSlider({
    super.key,
    required this.position,
    required this.total,
    required this.audioCubit,
  });

  @override
  Widget build(BuildContext context) {
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
