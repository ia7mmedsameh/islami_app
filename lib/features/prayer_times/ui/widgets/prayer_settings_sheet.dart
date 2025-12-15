import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings/settings_header.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings_sheet/settings_sheet_adhan.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings_sheet/settings_sheet_salah.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings_sheet/settings_sheet_azkar.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/settings_sheet/privacy_link_button.dart';
import 'package:permission_handler/permission_handler.dart';

class PrayerSettingsSheet extends StatefulWidget {
  const PrayerSettingsSheet({super.key});
  @override
  State<PrayerSettingsSheet> createState() => _PrayerSettingsSheetState();
}

class _PrayerSettingsSheetState extends State<PrayerSettingsSheet> {
  bool adhanEnabled = true, salahEnabled = true, azkarEnabled = false;
  bool isLoading = true;
  int salahInterval = 4, azkarInterval = 3;
  String? azkarError;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final box = await Hive.openBox('app_settings');
    final notificationStatus = await Permission.notification.status;

    setState(() {
      adhanEnabled = box.get('adhan_enabled', defaultValue: true);
      salahEnabled = box.get('salah_reminder_enabled', defaultValue: true);
      salahInterval = box.get('salah_interval_hours', defaultValue: 4);
      // الأذكار تعتمد على صلاحية الإشعارات
      azkarEnabled =
          notificationStatus.isGranted &&
          box.get('azkar_reminder_enabled', defaultValue: false);
      azkarInterval = box.get('azkar_interval_hours', defaultValue: 3);
      isLoading = false;
    });
  }

  void _showAzkarError(String message) {
    setState(() => azkarError = message);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => azkarError = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: ColorsManager.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          SettingsHeader(onClose: () => Navigator.pop(context)),
          isLoading ? _buildLoading() : _buildContent(),
        ],
      ),
    );
  }

  Widget _buildLoading() => const Expanded(
    child: Center(
      child: CircularProgressIndicator(color: ColorsManager.mainGold),
    ),
  );

  Widget _buildContent() => Expanded(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          SettingsSheetAdhan(
            adhanEnabled: adhanEnabled,
            onAdhanChanged: (v) => setState(() => adhanEnabled = v),
          ),
          SizedBox(height: 24.h),
          SettingsSheetSalah(
            salahEnabled: salahEnabled,
            salahInterval: salahInterval,
            onEnabledChanged: (v) => setState(() => salahEnabled = v),
            onIntervalChanged: (v) => setState(() => salahInterval = v),
          ),
          SizedBox(height: 24.h),
          SettingsSheetAzkar(
            azkarEnabled: azkarEnabled,
            azkarInterval: azkarInterval,
            errorMessage: azkarError,
            onEnabledChanged: (v) => setState(() => azkarEnabled = v),
            onIntervalChanged: (v) => setState(() => azkarInterval = v),
            onError: _showAzkarError,
          ),
          SizedBox(height: 24.h),
          const PrivacyLinkButton(),
        ],
      ),
    ),
  );
}
