
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String prefixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const AppTextField({
    super.key, required this.hintText, required this.prefixIcon, this.controller, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      cursorColor: ColorsManager.mainGold,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.font16WhiteBold,
        prefixIcon: Container(
          margin: EdgeInsets.only(
            left: 8.w,
            right: 15.w,
            top: 15.h,
            bottom: 15.h,
          ),
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(prefixIcon),
        ),
        filled: true,
        fillColor: ColorsManager.black.withValues(alpha: 0.8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorsManager.mainGold,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorsManager.mainGold,
            width: 2,
          ),
        ),
      ),
      style: AppTextStyles.font16WhiteBold,
    );
  }
}
