import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/next_prayer_section.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_date_header.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_settings_section.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_times_row.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_card/prayer_card_state.dart';

class PrayerTimesCard extends StatefulWidget {
  final PrayerTimesResponse data;

  const PrayerTimesCard({super.key, required this.data});

  @override
  State<PrayerTimesCard> createState() => _PrayerTimesCardState();
}

class _PrayerTimesCardState extends State<PrayerTimesCard>
    with PrayerCardState {
  @override
  void initState() {
    super.initState();
    initPrayerCardState(widget.data);
  }

  @override
  void dispose() {
    disposePrayerCardState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.mainGold.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          PrayerDateHeader(date: widget.data.data.date),
          SizedBox(height: 20.h),
          PrayerTimesRow(timings: widget.data.data.timings),
          SizedBox(height: 20.h),
          PrayerSettingsSection(
            adhanEnabled: adhanEnabled,
            salahReminderEnabled: salahReminderEnabled,
            azkarReminderEnabled: azkarReminderEnabled,
            onAdhanChanged: (v) {
              setState(() => adhanEnabled = v);
              saveSettings();
            },
            onSalahChanged: (v) {
              setState(() => salahReminderEnabled = v);
              saveSettings();
            },
            onAzkarChanged: (v) {
              setState(() => azkarReminderEnabled = v);
              saveSettings();
            },
          ),
          SizedBox(height: 20.h),
          NextPrayerSection(
            nextPrayer: nextPrayer,
            timeRemaining: timeRemaining,
          ),
        ],
      ),
    );
  }
}
