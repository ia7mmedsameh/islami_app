import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/mini_player/mini_player_info.dart';
import 'package:islami_app/core/widgets/mini_player/mini_player_controls.dart';

class MiniPlayerContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isPlaying;
  final bool showProgress;
  final double progress;
  final IconData icon;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;
  final VoidCallback? onTap;

  const MiniPlayerContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isPlaying,
    required this.showProgress,
    required this.progress,
    required this.icon,
    required this.onPlayPause,
    required this.onStop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showProgress)
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade800,
              valueColor: const AlwaysStoppedAnimation<Color>(
                ColorsManager.mainGold,
              ),
              minHeight: 2,
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: ColorsManager.mainGold, size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: MiniPlayerInfo(
                    title: title,
                    subtitle: subtitle,
                    onTap: onTap,
                  ),
                ),
                MiniPlayerControls(
                  isPlaying: isPlaying,
                  onPlayPause: onPlayPause,
                  onStop: onStop,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
