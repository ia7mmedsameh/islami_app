import 'dart:convert';
import 'package:hive/hive.dart';

class AudioHandlerStorage {
  static Future<String> getSurahName(int surahNumber) async {
    try {
      final box = await Hive.openBox('surahs_box');
      final cachedData = box.get('surahs_data');
      if (cachedData != null) {
        final jsonData = jsonDecode(cachedData as String);
        final surahs = jsonData['data'] as List?;
        if (surahs != null) {
          for (final surah in surahs) {
            if (surah['number'] == surahNumber)
              return surah['name'] ?? 'سورة $surahNumber';
          }
        }
      }
    } catch (_) {}
    try {
      final box = await Hive.openBox('app_settings');
      final map = box.get('surah_names_map');
      if (map != null && map is Map) {
        final name = map[surahNumber.toString()];
        if (name != null) return name;
      }
    } catch (_) {}
    return 'سورة $surahNumber';
  }

  static Future<void> savePlayback(
    int surahNumber,
    Duration position,
    String? surahName,
  ) async {
    try {
      final box = await Hive.openBox('app_settings');
      await box.put('last_surah_number', surahNumber);
      await box.put('last_surah_position', position.inMilliseconds);
      await box.put('last_audio_type', 'quran');
      if (surahName != null) await box.put('last_surah_name', surahName);
    } catch (_) {}
  }

  static Future<int?> loadCurrentSurah() async {
    try {
      final box = await Hive.openBox('app_settings');
      final saved = box.get('last_surah_number');
      if (saved != null && saved is int) return saved;
    } catch (_) {}
    return null;
  }
}
