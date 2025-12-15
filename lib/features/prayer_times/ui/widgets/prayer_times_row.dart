import 'package:flutter/material.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_time_calculator.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_time_item.dart';

class PrayerTimesRow extends StatelessWidget {
  final Timings timings;

  const PrayerTimesRow({super.key, required this.timings});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PrayerTimeItem(
          name: 'الفجر',
          time: PrayerTimeCalculator.formatTime(timings.fajr),
        ),
        PrayerTimeItem(
          name: 'الظهر',
          time: PrayerTimeCalculator.formatTime(timings.dhuhr),
        ),
        PrayerTimeItem(
          name: 'العصر',
          time: PrayerTimeCalculator.formatTime(timings.asr),
        ),
        PrayerTimeItem(
          name: 'المغرب',
          time: PrayerTimeCalculator.formatTime(timings.maghrib),
        ),
        PrayerTimeItem(
          name: 'العشاء',
          time: PrayerTimeCalculator.formatTime(timings.isha),
        ),
      ],
    );
  }
}
