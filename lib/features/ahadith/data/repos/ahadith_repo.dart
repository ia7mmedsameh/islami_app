import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'package:islami_app/core/helpers/constants.dart';
import 'package:islami_app/core/networking/api_error_handler.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/core/networking/api_service.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';

class AhadithRepo {
  final HadithApiService hadithApiService;

  AhadithRepo(this.hadithApiService);

  /// جلب البيانات المحلية فقط (بدون API)
  ApiResult<AhadithResponseModel>? getCachedAhadith() {
    try {
      final box = Hive.box(kAhadithBoxName);
      final cachedData = box.get(kAhadithDataKey);
      if (cachedData != null) {
        try {
          final jsonData = jsonDecode(cachedData as String);
          final cachedModel = AhadithResponseModel.fromJson(jsonData);
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

  Future<ApiResult<AhadithResponseModel>> getAllHadiths({
    bool forceRefresh = false,
  }) async {
    try {
      final box = Hive.box(kAhadithBoxName);

      // إذا لم يكن forceRefresh، نفحص البيانات المحلية أولاً
      if (!forceRefresh) {
        final cachedData = box.get(kAhadithDataKey);
        if (cachedData != null) {
          try {
            final jsonData = jsonDecode(cachedData as String);
            final cachedModel = AhadithResponseModel.fromJson(jsonData);
            return ApiResult.success(cachedModel);
          } catch (_) {
            // إذا فشل parsing البيانات المحلية، نكمل لجلبها من API
          }
        }
      }

      // جلب البيانات من API
      final response = await hadithApiService.getAllHadiths();

      // حفظ البيانات في Hive
      try {
        final jsonString = jsonEncode(response.toJson());
        await box.put(kAhadithDataKey, jsonString);
      } catch (_) {
        // إذا فشل الحفظ، نكمل بدون error
      }

      return ApiResult.success(response);
    } catch (error) {
      // في حالة error، نحاول إرجاع البيانات المحلية كـ fallback
      try {
        final box = Hive.box(kAhadithBoxName);
        final cachedData = box.get(kAhadithDataKey);
        if (cachedData != null) {
          final jsonData = jsonDecode(cachedData as String);
          final cachedModel = AhadithResponseModel.fromJson(jsonData);
          return ApiResult.success(cachedModel);
        }
      } catch (_) {
        // إذا فشل، نرجع error
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
