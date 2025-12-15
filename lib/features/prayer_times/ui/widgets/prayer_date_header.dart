import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';

class PrayerDateHeader extends StatelessWidget {
  final DateInfo date;

  const PrayerDateHeader({super.key, required this.date});

  static const _weekdays = {
    'Monday': 'الإثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildText(date.gregorian.date),
        Column(
          children: [
            _buildText('مواقيت الصلاة', 14),
            _buildText(_weekdays[date.gregorian.weekday.en] ?? ''),
          ],
        ),
        _buildText(date.hijri.date),
      ],
    );
  }

  Widget _buildText(String text, [double? size]) {
    return Text(
      text,
      style: AppTextStyles.font16WhiteBold.copyWith(
        color: ColorsManager.black,
        fontSize: (size ?? 16).sp,
      ),
    );
  }
}
