// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayerTimesResponse _$PrayerTimesResponseFromJson(Map<String, dynamic> json) =>
    PrayerTimesResponse(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: PrayerTimesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrayerTimesResponseToJson(
  PrayerTimesResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'data': instance.data,
};

PrayerTimesData _$PrayerTimesDataFromJson(Map<String, dynamic> json) =>
    PrayerTimesData(
      timings: Timings.fromJson(json['timings'] as Map<String, dynamic>),
      date: DateInfo.fromJson(json['date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrayerTimesDataToJson(PrayerTimesData instance) =>
    <String, dynamic>{'timings': instance.timings, 'date': instance.date};

Timings _$TimingsFromJson(Map<String, dynamic> json) => Timings(
  fajr: json['Fajr'] as String,
  sunrise: json['Sunrise'] as String,
  dhuhr: json['Dhuhr'] as String,
  asr: json['Asr'] as String,
  sunset: json['Sunset'] as String,
  maghrib: json['Maghrib'] as String,
  isha: json['Isha'] as String,
);

Map<String, dynamic> _$TimingsToJson(Timings instance) => <String, dynamic>{
  'Fajr': instance.fajr,
  'Sunrise': instance.sunrise,
  'Dhuhr': instance.dhuhr,
  'Asr': instance.asr,
  'Sunset': instance.sunset,
  'Maghrib': instance.maghrib,
  'Isha': instance.isha,
};

DateInfo _$DateInfoFromJson(Map<String, dynamic> json) => DateInfo(
  readable: json['readable'] as String,
  timestamp: json['timestamp'] as String,
  hijri: HijriDate.fromJson(json['hijri'] as Map<String, dynamic>),
  gregorian: GregorianDate.fromJson(json['gregorian'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DateInfoToJson(DateInfo instance) => <String, dynamic>{
  'readable': instance.readable,
  'timestamp': instance.timestamp,
  'hijri': instance.hijri,
  'gregorian': instance.gregorian,
};

HijriDate _$HijriDateFromJson(Map<String, dynamic> json) => HijriDate(
  date: json['date'] as String,
  format: json['format'] as String,
  day: json['day'] as String,
  month: HijriMonth.fromJson(json['month'] as Map<String, dynamic>),
  year: json['year'] as String,
);

Map<String, dynamic> _$HijriDateToJson(HijriDate instance) => <String, dynamic>{
  'date': instance.date,
  'format': instance.format,
  'day': instance.day,
  'month': instance.month,
  'year': instance.year,
};

HijriMonth _$HijriMonthFromJson(Map<String, dynamic> json) => HijriMonth(
  number: (json['number'] as num).toInt(),
  en: json['en'] as String,
  ar: json['ar'] as String,
);

Map<String, dynamic> _$HijriMonthToJson(HijriMonth instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
      'ar': instance.ar,
    };

GregorianDate _$GregorianDateFromJson(Map<String, dynamic> json) =>
    GregorianDate(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as String,
      month: GregorianMonth.fromJson(json['month'] as Map<String, dynamic>),
      year: json['year'] as String,
      weekday: Weekday.fromJson(json['weekday'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GregorianDateToJson(GregorianDate instance) =>
    <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'weekday': instance.weekday,
    };

Weekday _$WeekdayFromJson(Map<String, dynamic> json) =>
    Weekday(en: json['en'] as String);

Map<String, dynamic> _$WeekdayToJson(Weekday instance) => <String, dynamic>{
  'en': instance.en,
};

GregorianMonth _$GregorianMonthFromJson(Map<String, dynamic> json) =>
    GregorianMonth(
      number: (json['number'] as num).toInt(),
      en: json['en'] as String,
    );

Map<String, dynamic> _$GregorianMonthToJson(GregorianMonth instance) =>
    <String, dynamic>{'number': instance.number, 'en': instance.en};
