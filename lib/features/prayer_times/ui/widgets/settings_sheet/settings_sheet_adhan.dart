import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_switch_tile.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_section.dart';

class SettingsSheetAdhan extends StatelessWidget {
  final bool adhanEnabled;
  final ValueChanged<bool> onAdhanChanged;

  const SettingsSheetAdhan({
    super.key,
    required this.adhanEnabled,
    required this.onAdhanChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.mosque,
      title: 'الأذان',
      children: [
        SettingsSwitchTile(
          title: 'تفعيل الأذان',
          subtitle: 'تشغيل الأذان وقت الصلاة',
          value: adhanEnabled,
          onChanged: (v) async {
            onAdhanChanged(v);
            final box = await Hive.openBox('app_settings');
            await box.put('adhan_enabled', v);
            if (context.mounted) {
              await context.read<PrayerTimesCubit>().toggleAdhan(v);
            }
          },
        ),
      ],
    );
  }
}
