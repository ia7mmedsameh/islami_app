import 'package:json_annotation/json_annotation.dart';

part 'prayer_times_model.g.dart';

@JsonSerializable()
class PrayerTimesResponse {
  final int code;
  final String status;
  final PrayerTimesData data;

  PrayerTimesResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrayerTimesResponseToJson(this);
}

@JsonSerializable()
class PrayerTimesData {
  final Timings timings;
  final DateInfo date;

  PrayerTimesData({required this.timings, required this.date});

  factory PrayerTimesData.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimesDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrayerTimesDataToJson(this);
}

@JsonSerializable()
class Timings {
  @JsonKey(name: 'Fajr')
  final String fajr;
  @JsonKey(name: 'Sunrise')
  final String sunrise;
  @JsonKey(name: 'Dhuhr')
  final String dhuhr;
  @JsonKey(name: 'Asr')
  final String asr;
  @JsonKey(name: 'Sunset')
  final String sunset;
  @JsonKey(name: 'Maghrib')
  final String maghrib;
  @JsonKey(name: 'Isha')
  final String isha;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
  });

  factory Timings.fromJson(Map<String, dynamic> json) =>
      _$TimingsFromJson(json);

  Map<String, dynamic> toJson() => _$TimingsToJson(this);
}

@JsonSerializable()
class DateInfo {
  final String readable;
  final String timestamp;
  final HijriDate hijri;
  final GregorianDate gregorian;

  DateInfo({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) =>
      _$DateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DateInfoToJson(this);
}

@JsonSerializable()
class HijriDate {
  final String date;
  final String format;
  final String day;
  final HijriMonth month;
  final String year;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.month,
    required this.year,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) =>
      _$HijriDateFromJson(json);

  Map<String, dynamic> toJson() => _$HijriDateToJson(this);
}

@JsonSerializable()
class HijriMonth {
  final int number;
  final String en;
  final String ar;

  HijriMonth({required this.number, required this.en, required this.ar});

  factory HijriMonth.fromJson(Map<String, dynamic> json) =>
      _$HijriMonthFromJson(json);

  Map<String, dynamic> toJson() => _$HijriMonthToJson(this);
}

@JsonSerializable()
class GregorianDate {
  final String date;
  final String format;
  final String day;
  final GregorianMonth month;
  final String year;
  final Weekday weekday;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.month,
    required this.year,
    required this.weekday,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) =>
      _$GregorianDateFromJson(json);

  Map<String, dynamic> toJson() => _$GregorianDateToJson(this);
}

@JsonSerializable()
class Weekday {
  final String en;

  Weekday({required this.en});

  factory Weekday.fromJson(Map<String, dynamic> json) =>
      _$WeekdayFromJson(json);

  Map<String, dynamic> toJson() => _$WeekdayToJson(this);
}

@JsonSerializable()
class GregorianMonth {
  final int number;
  final String en;

  GregorianMonth({required this.number, required this.en});

  factory GregorianMonth.fromJson(Map<String, dynamic> json) =>
      _$GregorianMonthFromJson(json);

  Map<String, dynamic> toJson() => _$GregorianMonthToJson(this);
}
