import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';

class AudioControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;
  final double size;

  const AudioControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isActive,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? ColorsManager.mainGold.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.1),
          border: Border.all(
            color: isActive
                ? ColorsManager.mainGold
                : Colors.white.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? ColorsManager.mainGold : Colors.white,
          size: size,
        ),
      ),
    );
  }
}
