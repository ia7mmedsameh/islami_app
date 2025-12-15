import 'package:hive_flutter/hive_flutter.dart';
import 'package:islami_app/features/prayer_times/data/api/azkar_api_service.dart';
import 'package:islami_app/features/prayer_times/data/models/azkar_model.dart';

class AzkarList {
  static List<String>? _cachedAzkar;
  static const String _boxName = 'azkar_cache';
  static const String _azkarKey = 'azkar_list';
  static const List<String> _fallbackAzkar = [
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
    'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
    'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
    'رَبِّ اغْفِرْ لِي وَارْحَمْنِي وَاهْدِنِي وَارْزُقْنِي',
    'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ',
    'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
  ];

  static Future<void> loadAzkar(AzkarApiService apiService) async {
    if (_cachedAzkar != null && _cachedAzkar!.isNotEmpty) return;
    try {
      final box = await Hive.openBox(_boxName);
      final cachedList = box.get(_azkarKey);
      if (cachedList != null && cachedList is List && cachedList.isNotEmpty) {
        _cachedAzkar = List<String>.from(cachedList);
        return;
      }
      final data = await apiService.getAzkar();
      final List<String> allAzkar = [];
      for (var category in AzkarCategory.allCategories) {
        if (data.containsKey(category.apiKey))
          _parseCategory(data[category.apiKey], allAzkar);
      }
      if (allAzkar.isNotEmpty) {
        _cachedAzkar = allAzkar;
        try {
          await box.put(_azkarKey, allAzkar);
        } catch (_) {}
      } else {
        _cachedAzkar = _fallbackAzkar;
      }
    } catch (_) {
      _cachedAzkar = _fallbackAzkar;
    }
  }

  static void _parseCategory(dynamic categoryData, List<String> allAzkar) {
    if (categoryData is! List) return;
    for (var item in categoryData) {
      if (item is List) {
        for (var subItem in item) _addZikr(subItem, allAzkar);
      } else {
        _addZikr(item, allAzkar);
      }
    }
  }

  static void _addZikr(dynamic item, List<String> allAzkar) {
    if (item is! Map) return;
    try {
      final map = Map<String, dynamic>.from(item);
      final zikr = ZikrItem.fromJson(map);
      if (zikr.cleanContent.isNotEmpty && zikr.cleanContent.length > 10)
        allAzkar.add(zikr.cleanContent);
    } catch (_) {}
  }

  static String getRandomZikr() {
    final azkar = List<String>.from(_cachedAzkar ?? _fallbackAzkar);
    azkar.shuffle();
    return azkar.first;
  }
}
