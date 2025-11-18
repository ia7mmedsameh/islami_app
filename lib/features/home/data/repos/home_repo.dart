import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/networking/api_error_handler.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/core/networking/api_service.dart';
import 'package:islami_app/features/home/data/models/surahs_response_model.dart';

class HomeRepo {
  final ApiService apiService;

  HomeRepo(this.apiService);

  /// جلب البيانات المحلية فقط (بدون API)
  ApiResult<SurahsResponseModel>? getCachedSurahs() {
    try {
      final box = Hive.box(kSurahsBoxName);
      final cachedData = box.get(kSurahsDataKey);
      if (cachedData != null) {
        try {
          final jsonData = jsonDecode(cachedData as String);
          final cachedModel = SurahsResponseModel.fromJson(jsonData);
          return ApiResult.success(cachedModel);
        } catch (_) {
          return null;
        }
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  Future<ApiResult<SurahsResponseModel>> getAllSurahs({bool forceRefresh = false}) async {
    try {
      final box = Hive.box(kSurahsBoxName);
      
      // إذا لم يكن forceRefresh، نفحص البيانات المحلية أولاً
      if (!forceRefresh) {
        final cachedData = box.get(kSurahsDataKey);
        if (cachedData != null) {
          try {
            final jsonData = jsonDecode(cachedData as String);
            final cachedModel = SurahsResponseModel.fromJson(jsonData);
            return ApiResult.success(cachedModel);
          } catch (_) {
            // إذا فشل parsing البيانات المحلية، نكمل لجلبها من API
          }
        }
      }

      // جلب البيانات من API
      final response = await apiService.getAllSurahs();
      
      // حفظ البيانات في Hive
      try {
        final jsonString = jsonEncode(response.toJson());
        await box.put(kSurahsDataKey, jsonString);
      } catch (_) {
        // إذا فشل الحفظ، نكمل بدون error
      }
      
      return ApiResult.success(response);
    } catch (error) {
      // في حالة error، نحاول إرجاع البيانات المحلية كـ fallback
      try {
        final box = Hive.box(kSurahsBoxName);
        final cachedData = box.get(kSurahsDataKey);
        if (cachedData != null) {
          final jsonData = jsonDecode(cachedData as String);
          final cachedModel = SurahsResponseModel.fromJson(jsonData);
          return ApiResult.success(cachedModel);
        }
      } catch (_) {
        // إذا فشل، نرجع error
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
