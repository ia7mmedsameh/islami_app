import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_time_calculator.dart';
import 'package:permission_handler/permission_handler.dart';

mixin PrayerCardState<T extends StatefulWidget> on State<T> {
  Timer? timer;
  String nextPrayer = '';
  String timeRemaining = '';
  bool adhanEnabled = true;
  bool salahReminderEnabled = true;
  bool azkarReminderEnabled = false;
  late PrayerTimesResponse _data;

  void initPrayerCardState(PrayerTimesResponse data) {
    _data = data;
    _loadSettings();
    _updateNextPrayer();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(_updateNextPrayer);
        _loadSettings();
      }
    });
  }

  void disposePrayerCardState() {
    timer?.cancel();
  }

  Future<void> _loadSettings() async {
    final box = await Hive.openBox('app_settings');
    final notificationStatus = await Permission.notification.status;
    if (mounted) {
      setState(() {
        adhanEnabled = box.get('adhan_enabled', defaultValue: true);
        salahReminderEnabled = box.get(
          'salah_reminder_enabled',
          defaultValue: true,
        );
        // الأذكار تعتمد على صلاحية الإشعارات
        azkarReminderEnabled =
            notificationStatus.isGranted &&
            box.get('azkar_reminder_enabled', defaultValue: false);
      });
    }
  }

  Future<void> saveSettings() async {
    final box = await Hive.openBox('app_settings');
    await box.put('adhan_enabled', adhanEnabled);
    await box.put('salah_reminder_enabled', salahReminderEnabled);
    await box.put('azkar_reminder_enabled', azkarReminderEnabled);
  }

  void _updateNextPrayer() {
    final prayers = PrayerTimeCalculator.getPrayerTimes(_data.data.timings);
    final next = PrayerTimeCalculator.calculateNextPrayer(prayers);
    nextPrayer = next['name']!;
    timeRemaining = next['time']!;
  }
}
