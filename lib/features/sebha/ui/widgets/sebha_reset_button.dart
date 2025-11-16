import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/styles.dart';

class SebhaResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SebhaResetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'تصفير عداد التسبيح',
        style: AppTextStyles.font24WhiteBold,
        textAlign: TextAlign.center,
      ),
    );
  }
}
