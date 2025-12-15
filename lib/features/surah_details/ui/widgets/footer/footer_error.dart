import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/styles.dart';

class FooterError extends StatelessWidget {
  final String message;

  const FooterError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTextStyles.font16WhiteBold.copyWith(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}
