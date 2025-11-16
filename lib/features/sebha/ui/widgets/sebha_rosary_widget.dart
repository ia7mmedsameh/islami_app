import 'package:flutter/material.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/theming/styles.dart';

class SebhaRosaryWidget extends StatelessWidget {
  final int counter;
  final VoidCallback onTap;

  const SebhaRosaryWidget({
    super.key,
    required this.counter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Rosary image
            Image.asset(
              Assets.imagesSebha,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
            // Center content - positioned at 75% from bottom
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0, 0.3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Arabic text: سبحان الله
                    Text('سبحان الله', style: AppTextStyles.font36WhiteBold),
                    verticalSpace(10),
                    // Counter
                    Text(
                      '$counter',
                      style: AppTextStyles.font36WhiteBold.copyWith(
                        fontSize: 40,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
