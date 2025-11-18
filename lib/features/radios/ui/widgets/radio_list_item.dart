import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';

class RadioListItem extends StatelessWidget {
  final RadioData radio;
  final bool isSelected;
  final VoidCallback onTap;

  const RadioListItem({
    super.key,
    required this.radio,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      title: Text(
        radio.name ?? '',
        style: AppTextStyles.font16WhiteBold.copyWith(
          color: isSelected ? ColorsManager.mainGold : Colors.white,
        ),
      ),
      trailing: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? ColorsManager.mainGold : Colors.grey.withOpacity(0.7),
      ),
      onTap: onTap,
    );
  }
}

