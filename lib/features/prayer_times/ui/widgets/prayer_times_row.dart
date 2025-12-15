import 'package:flutter/material.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_time_calculator.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/prayer_time_item.dart';

class PrayerTimesRow extends StatelessWidget {
  final Timings timings;

  const PrayerTimesRow({super.key, required this.timings});

  String _getNextPrayerName() {
    final prayers = PrayerTimeCalculator.getPrayerTimes(timings);
    final next = PrayerTimeCalculator.calculateNextPrayer(prayers);
    return next['name'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final nextPrayer = _getNextPrayerName();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PrayerTimeItem(
          name: 'الفجر',
          time: PrayerTimeCalculator.formatTime(timings.fajr),
          isNext: nextPrayer == 'الفجر',
        ),
        PrayerTimeItem(
          name: 'الظهر',
          time: PrayerTimeCalculator.formatTime(timings.dhuhr),
          isNext: nextPrayer == 'الظهر',
        ),
        PrayerTimeItem(
          name: 'العصر',
          time: PrayerTimeCalculator.formatTime(timings.asr),
          isNext: nextPrayer == 'العصر',
        ),
        PrayerTimeItem(
          name: 'المغرب',
          time: PrayerTimeCalculator.formatTime(timings.maghrib),
          isNext: nextPrayer == 'المغرب',
        ),
        PrayerTimeItem(
          name: 'العشاء',
          time: PrayerTimeCalculator.formatTime(timings.isha),
          isNext: nextPrayer == 'العشاء',
        ),
      ],
    );
  }
}
