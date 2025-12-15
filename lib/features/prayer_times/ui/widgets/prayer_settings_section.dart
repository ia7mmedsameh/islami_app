import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/setting_switch.dart';

class PrayerSettingsSection extends StatelessWidget {
  final bool adhanEnabled;
  final bool salahReminderEnabled;
  final bool azkarReminderEnabled;
  final ValueChanged<bool> onAdhanChanged;
  final ValueChanged<bool> onSalahChanged;
  final ValueChanged<bool> onAzkarChanged;

  const PrayerSettingsSection({
    super.key,
    required this.adhanEnabled,
    required this.salahReminderEnabled,
    required this.azkarReminderEnabled,
    required this.onAdhanChanged,
    required this.onSalahChanged,
    required this.onAzkarChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SettingSwitch(
            label: 'تشغيل الأذان',
            value: adhanEnabled,
            onChanged: (v) {
              onAdhanChanged(v);
              context.read<PrayerTimesCubit>().toggleAdhan(v);
            },
          ),
          SizedBox(height: 8.h),
          SettingSwitch(
            label: 'تذكير الصلاة على النبي',
            value: salahReminderEnabled,
            onChanged: (v) {
              onSalahChanged(v);
              context.read<PrayerTimesCubit>().toggleSalahReminder(v);
            },
          ),
          SizedBox(height: 8.h),
          SettingSwitch(
            label: 'تذكير بالأذكار',
            value: azkarReminderEnabled,
            onChanged: (v) {
              onAzkarChanged(v);
              context.read<PrayerTimesCubit>().toggleAzkarReminder(v);
            },
          ),
        ],
      ),
    );
  }
}
