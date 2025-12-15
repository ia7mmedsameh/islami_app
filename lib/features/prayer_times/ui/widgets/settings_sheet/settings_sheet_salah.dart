import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_switch_tile.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_interval_selector.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_section.dart';

class SettingsSheetSalah extends StatelessWidget {
  final bool salahEnabled;
  final int salahInterval;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onIntervalChanged;

  const SettingsSheetSalah({
    super.key,
    required this.salahEnabled,
    required this.salahInterval,
    required this.onEnabledChanged,
    required this.onIntervalChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.notifications_active,
      title: 'الصلاة على النبي',
      children: [
        SettingsSwitchTile(
          title: 'تفعيل التذكير',
          subtitle: 'تذكير بالصلاة على النبي ﷺ',
          value: salahEnabled,
          onChanged: (v) async {
            onEnabledChanged(v);
            final box = await Hive.openBox('app_settings');
            await box.put('salah_reminder_enabled', v);
            if (context.mounted) {
              await context.read<PrayerTimesCubit>().toggleSalahReminder(v);
            }
          },
        ),
        if (salahEnabled) ...[
          SizedBox(height: 12.h),
          SettingsIntervalSelector(
            selectedInterval: salahInterval,
            intervals: const [2, 3, 4, 6, 12],
            onChanged: (h) async {
              onIntervalChanged(h);
              if (context.mounted) {
                await context.read<PrayerTimesCubit>().updateSalahInterval(h);
              }
            },
          ),
        ],
      ],
    );
  }
}
