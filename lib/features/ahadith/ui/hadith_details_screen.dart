import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';
import 'package:islami_app/features/ahadith/ui/widgets/hadith_details_body.dart';

class HadithDetailsScreen extends StatelessWidget {
  final Data hadith;

  const HadithDetailsScreen({super.key, required this.hadith});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.mainGold),
        backgroundColor: Colors.transparent,
        title: Text(
          'الحديث كامل',
          style: AppTextStyles.font20WhiteBold.copyWith(
            color: ColorsManager.mainGold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: HadithDetailsBody(hadith: hadith),
    );
  }
}
