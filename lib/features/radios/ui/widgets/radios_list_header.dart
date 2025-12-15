import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/widgets/app_text_form_field.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';

class RadiosListHeader extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;

  const RadiosListHeader({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          const IslamiLogoAndMosque(),
          verticalSpace(25),
          AppTextField(
            hintText: 'اسم الراديو',
            prefixIcon: Assets.svgsIconRadio,
            controller: searchController,
            onChanged: onChanged,
          ),
          verticalSpace(25),
        ],
      ),
    );
  }
}
