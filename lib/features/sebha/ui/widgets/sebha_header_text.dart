import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/styles.dart';

class SebhaHeaderText extends StatelessWidget {
  const SebhaHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
      style: AppTextStyles.font36WhiteBold,
      textAlign: TextAlign.center,
    );
  }
}
