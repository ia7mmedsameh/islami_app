import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';

class PrayerTimeCalculator {
  static Map<String, DateTime> getPrayerTimes(Timings timings) {
    return {
      'الفجر': parseTime(timings.fajr),
      'الظهر': parseTime(timings.dhuhr),
      'العصر': parseTime(timings.asr),
      'المغرب': parseTime(timings.maghrib),
      'العشاء': parseTime(timings.isha),
    };
  }

  static DateTime parseTime(String time) {
    final parts = time.split(' ')[0].split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  static String formatTime(String time) {
    final parts = time.split(' ')[0].split(':');
    if (parts.length < 2) return time;
    var hour = int.parse(parts[0]);
    final period = hour >= 12 ? 'م' : 'ص';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;
    return '$hour:${parts[1]} $period';
  }

  static Map<String, String> calculateNextPrayer(
    Map<String, DateTime> prayers,
  ) {
    final now = DateTime.now();
    var nextEntry = prayers.entries.firstWhere(
      (e) => e.value.isAfter(now),
      orElse: () =>
          MapEntry('الفجر', prayers['الفجر']!.add(const Duration(days: 1))),
    );

    final diff = nextEntry.value.difference(now);
    return {
      'name': nextEntry.key,
      'time':
          '${diff.inHours.toString().padLeft(2, '0')}:'
          '${diff.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
          '${diff.inSeconds.remainder(60).toString().padLeft(2, '0')}',
    };
  }
}
