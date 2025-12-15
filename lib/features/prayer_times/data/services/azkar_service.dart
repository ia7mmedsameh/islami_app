import 'package:hive_flutter/hive_flutter.dart';
import 'package:islami_app/features/prayer_times/data/api/azkar_api_service.dart';
import 'package:islami_app/features/prayer_times/data/models/azkar_model.dart';

class AzkarService {
  final AzkarApiService _apiService;
  static const String _boxName = 'azkar_service_cache';
  static const String _cacheKey = 'azkar_data';
  static Map<String, dynamic>? _memoryCache;

  AzkarService(this._apiService);

  Future<List<ZikrItem>> getAzkar(String categoryKey) async {
    try {
      if (_memoryCache == null) {
        final box = await Hive.openBox(_boxName);
        final cachedData = box.get(_cacheKey);

        if (cachedData != null) {
          try {
            if (cachedData is Map) {
              _memoryCache = Map<String, dynamic>.from(cachedData);
            }
          } catch (_) {
            _memoryCache = null;
          }
        }

        if (_memoryCache == null) {
          final data = await _apiService.getAzkar();
          _memoryCache = data;
          try {
            await box.put(_cacheKey, data);
          } catch (_) {}
        }
      }

      if (_memoryCache == null || !_memoryCache!.containsKey(categoryKey)) {
        throw Exception('الفئة المطلوبة غير موجودة');
      }

      final result = _parseAzkar(_memoryCache![categoryKey]);

      if (result.isEmpty) {
        throw Exception('لا توجد أذكار في هذه الفئة');
      }

      return result;
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('حدث خطأ أثناء تحميل الأذكار: ${e.toString()}');
    }
  }

  List<ZikrItem> _parseAzkar(dynamic data) {
    final List<ZikrItem> result = [];
    if (data == null) return result;
    if (data is! List) return result;

    try {
      for (var item in data) {
        if (item is List) {
          for (var subItem in item) {
            if (subItem is Map) {
              final map = Map<String, dynamic>.from(subItem);
              final category = map['category'];
              if (category != null && category != 'stop') {
                try {
                  result.add(ZikrItem.fromJson(map));
                } catch (_) {
                  continue;
                }
              }
            }
          }
        } else if (item is Map) {
          final map = Map<String, dynamic>.from(item);
          final category = map['category'];
          if (category != null && category != 'stop') {
            try {
              result.add(ZikrItem.fromJson(map));
            } catch (_) {
              continue;
            }
          }
        }
      }
    } catch (_) {}

    return result;
  }
}
