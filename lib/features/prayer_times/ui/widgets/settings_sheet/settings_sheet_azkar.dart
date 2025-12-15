import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_switch_tile.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_interval_selector.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_section.dart';

class SettingsSheetAzkar extends StatelessWidget {
  final bool azkarEnabled;
  final int azkarInterval;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onIntervalChanged;

  const SettingsSheetAzkar({
    super.key,
    required this.azkarEnabled,
    required this.azkarInterval,
    required this.onEnabledChanged,
    required this.onIntervalChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.auto_awesome,
      title: 'تذكير بالأذكار',
      children: [
        SettingsSwitchTile(
          title: 'تفعيل التذكير',
          subtitle: 'تذكير بأذكار متنوعة',
          value: azkarEnabled,
          onChanged: (v) async {
            onEnabledChanged(v);
            final box = await Hive.openBox('app_settings');
            await box.put('azkar_reminder_enabled', v);
            if (context.mounted) {
              await context.read<PrayerTimesCubit>().toggleAzkarReminder(v);
            }
          },
        ),
        if (azkarEnabled) ...[
          SizedBox(height: 12.h),
          SettingsIntervalSelector(
            selectedInterval: azkarInterval,
            intervals: const [2, 3, 4, 6, 8],
            onChanged: (h) async {
              onIntervalChanged(h);
              if (context.mounted) {
                await context.read<PrayerTimesCubit>().updateAzkarInterval(h);
              }
            },
          ),
        ],
      ],
    );
  }
}
