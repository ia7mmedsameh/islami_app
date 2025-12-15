import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_switch_tile.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_interval_selector.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_section.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsSheetAzkar extends StatelessWidget {
  final bool azkarEnabled;
  final int azkarInterval;
  final String? errorMessage;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onIntervalChanged;
  final void Function(String) onError;

  const SettingsSheetAzkar({
    super.key,
    required this.azkarEnabled,
    required this.azkarInterval,
    required this.onEnabledChanged,
    required this.onIntervalChanged,
    required this.onError,
    this.errorMessage,
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
            if (v) {
              // عند محاولة التفعيل، نتحقق من صلاحية الإشعارات
              final status = await Permission.notification.status;

              if (status.isPermanentlyDenied) {
                onError('يجب تفعيل الإشعارات من إعدادات الجهاز');
                openAppSettings();
                return;
              }

              if (!status.isGranted) {
                final result = await Permission.notification.request();
                if (!result.isGranted) {
                  onError('يجب تفعيل الإشعارات لاستخدام تذكير الأذكار');
                  return;
                }
              }
            }

            onEnabledChanged(v);
            final box = await Hive.openBox('app_settings');
            await box.put('azkar_reminder_enabled', v);
            if (context.mounted) {
              await context.read<PrayerTimesCubit>().toggleAzkarReminder(v);
            }
          },
        ),
        if (errorMessage != null) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.shade900.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade300,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    errorMessage!,
                    style: TextStyle(
                      color: Colors.red.shade300,
                      fontSize: 12.sp,
                      fontFamily: 'Janna-LT',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
