import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';

class PrayerCacheManager {
  static const _boxName = 'prayer_times_cache';
  static const _dataKey = 'cached_data_json';
  static const _timestampKey = 'cache_timestamp';

  static Future<void> save(PrayerTimesResponse data) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.put(_dataKey, jsonEncode(data.toJson()));
      await box.put(_timestampKey, DateTime.now().toIso8601String());
    } catch (_) {}
  }

  static Future<PrayerTimesResponse?> load() async {
    try {
      final box = await Hive.openBox(_boxName);
      final cached = box.get(_dataKey);
      if (cached is String) {
        return PrayerTimesResponse.fromJson(jsonDecode(cached));
      }
    } catch (_) {
      await clear();
    }
    return null;
  }

  static Future<void> clear() async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.clear();
    } catch (_) {}
  }

  static bool isValid(PrayerTimesResponse data) {
    // الـ cache صالح دائماً - مش محتاج نجيب مواقيت جديدة
    return true;
  }
}
