import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/setting_switch.dart';
import 'package:permission_handler/permission_handler.dart';

class PrayerSettingsSection extends StatefulWidget {
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
  State<PrayerSettingsSection> createState() => _PrayerSettingsSectionState();
}

class _PrayerSettingsSectionState extends State<PrayerSettingsSection> {
  String? azkarError;

  Future<void> _handleAzkarToggle(bool v) async {
    if (v) {
      final status = await Permission.notification.status;

      if (status.isPermanentlyDenied) {
        setState(() => azkarError = 'يجب تفعيل الإشعارات من إعدادات الجهاز');
        _clearErrorAfterDelay();
        openAppSettings();
        return;
      }

      if (!status.isGranted) {
        final result = await Permission.notification.request();
        if (!result.isGranted) {
          setState(
            () => azkarError = 'يجب تفعيل الإشعارات لاستخدام تذكير الأذكار',
          );
          _clearErrorAfterDelay();
          return;
        }
      }
    }

    widget.onAzkarChanged(v);
    if (mounted) {
      context.read<PrayerTimesCubit>().toggleAzkarReminder(v);
    }
  }

  void _clearErrorAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => azkarError = null);
    });
  }

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
            value: widget.adhanEnabled,
            onChanged: (v) {
              widget.onAdhanChanged(v);
              context.read<PrayerTimesCubit>().toggleAdhan(v);
            },
          ),
          SizedBox(height: 8.h),
          SettingSwitch(
            label: 'تذكير الصلاة على النبي',
            value: widget.salahReminderEnabled,
            onChanged: (v) {
              widget.onSalahChanged(v);
              context.read<PrayerTimesCubit>().toggleSalahReminder(v);
            },
          ),
          SizedBox(height: 8.h),
          SettingSwitch(
            label: 'تذكير بالأذكار',
            value: widget.azkarReminderEnabled,
            onChanged: _handleAzkarToggle,
          ),
          if (azkarError != null) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.red.shade900.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 18.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      azkarError!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Janna-LT',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => openAppSettings(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'الإعدادات',
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Janna-LT',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
