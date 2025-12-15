import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/prayer_times/data/models/azkar_model.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/azkar_bottom_sheet.dart';

class AzkarCards extends StatelessWidget {
  const AzkarCards({super.key});

  static const _icons = {
    'morning': Icons.wb_sunny,
    'evening': Icons.nightlight_round,
    'prayer': Icons.mosque,
    'tasbeeh': Icons.circle_outlined,
    'sleep': Icons.bedtime,
    'wakeup': Icons.wb_twilight,
    'quran': Icons.menu_book,
    'prophets': Icons.star,
  };

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.85,
      ),
      itemCount: AzkarCategory.allCategories.length,
      itemBuilder: (context, index) =>
          _buildCard(context, AzkarCategory.allCategories[index]),
    );
  }

  Widget _buildCard(BuildContext context, AzkarCategory category) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => AzkarBottomSheet(category: category),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.mainGold.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icons[category.icon] ?? Icons.menu_book,
              size: 50.sp,
              color: ColorsManager.mainGold,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                category.nameAr,
                style: AppTextStyles.font16WhiteBold.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                category.nameEn,
                style: AppTextStyles.font16WhiteBold.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 11.sp,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
