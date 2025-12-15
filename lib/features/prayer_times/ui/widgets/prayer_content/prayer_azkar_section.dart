import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/azkar_cards.dart';

class PrayerAzkarSection extends StatelessWidget {
  const PrayerAzkarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أذكار',
            style: AppTextStyles.font20WhiteBold.copyWith(
              color: ColorsManager.mainGold,
            ),
          ),
          SizedBox(height: 16.h),
          const AzkarCards(),
        ],
      ),
    );
  }
}
