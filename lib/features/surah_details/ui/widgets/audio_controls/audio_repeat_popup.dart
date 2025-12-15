import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';

class AudioRepeatPopup extends StatelessWidget {
  final Animation<double> animation;
  final RepeatMode repeatMode;

  const AudioRepeatPopup({
    super.key,
    required this.animation,
    required this.repeatMode,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getRepeatIcon(),
                color: ColorsManager.mainGold,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                _getRepeatText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getRepeatIcon() => switch (repeatMode) {
    RepeatMode.off => Icons.repeat_rounded,
    RepeatMode.one => Icons.repeat_one_rounded,
    RepeatMode.all => Icons.repeat_on_rounded,
  };

  String _getRepeatText() => switch (repeatMode) {
    RepeatMode.off => 'بدون تكرار',
    RepeatMode.one => 'تكرار السورة',
    RepeatMode.all => 'تكرار الكل',
  };
}
