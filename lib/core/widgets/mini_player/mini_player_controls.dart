import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';

class MiniPlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;

  const MiniPlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            padding: EdgeInsets.all(8.w),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: ColorsManager.mainGold,
              size: 28.sp,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onStop,
          child: Container(
            padding: EdgeInsets.all(8.w),
            child: Icon(Icons.close, color: Colors.grey.shade400, size: 24.sp),
          ),
        ),
      ],
    );
  }
}
