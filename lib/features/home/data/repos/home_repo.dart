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

  Future<ApiResult<SurahsResponseModel>> getAllSurahs({
    bool forceRefresh = false,
  }) async {
    try {
      final box = Hive.box(kSurahsBoxName);
      if (!forceRefresh) {
        final cachedData = box.get(kSurahsDataKey);
        if (cachedData != null) {
          try {
            final jsonData = jsonDecode(cachedData as String);
            final cachedModel = SurahsResponseModel.fromJson(jsonData);
            return ApiResult.success(cachedModel);
          } catch (_) {}
        }
      }
      final response = await apiService.getAllSurahs();
      try {
        final jsonString = jsonEncode(response.toJson());
        await box.put(kSurahsDataKey, jsonString);
      } catch (_) {}
      return ApiResult.success(response);
    } catch (error) {
      try {
        final box = Hive.box(kSurahsBoxName);
        final cachedData = box.get(kSurahsDataKey);
        if (cachedData != null) {
          final jsonData = jsonDecode(cachedData as String);
          final cachedModel = SurahsResponseModel.fromJson(jsonData);
          return ApiResult.success(cachedModel);
        }
      } catch (_) {}
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
