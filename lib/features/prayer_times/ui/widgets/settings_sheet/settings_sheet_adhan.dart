import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_cache_manager.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_switch_tile.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_section.dart';

class SettingsSheetAdhan extends StatefulWidget {
  final bool adhanEnabled;
  final ValueChanged<bool> onAdhanChanged;

  const SettingsSheetAdhan({
    super.key,
    required this.adhanEnabled,
    required this.onAdhanChanged,
  });

  @override
  State<SettingsSheetAdhan> createState() => _SettingsSheetAdhanState();
}

class _SettingsSheetAdhanState extends State<SettingsSheetAdhan> {
  bool _hasCachedData = true;

  @override
  void initState() {
    super.initState();
    _checkCachedData();
  }

  Future<void> _checkCachedData() async {
    final cached = await PrayerCacheManager.load();
    if (mounted) {
      setState(() {
        _hasCachedData = cached != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasCachedData) {
      return _buildDisabledSection();
    }
    return SettingsSection(
      icon: Icons.mosque,
      title: 'الأذان',
      children: [
        SettingsSwitchTile(
          title: 'تفعيل الأذان',
          subtitle: 'تشغيل الأذان وقت الصلاة',
          value: widget.adhanEnabled,
          onChanged: (v) async {
            widget.onAdhanChanged(v);
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

  Widget _buildDisabledSection() {
    return SettingsSection(
      icon: Icons.mosque,
      title: 'الأذان',
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorsManager.gray.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'يرجى تفعيل صلاحية الموقع اولاً',
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
