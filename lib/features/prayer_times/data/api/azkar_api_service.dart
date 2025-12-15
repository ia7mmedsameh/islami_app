import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class AzkarApiService {
  final Dio _dio;

  AzkarApiService(this._dio);

  Future<Map<String, dynamic>> getAzkar() async {
    try {
      final response = await _dio.get(
        'https://raw.githubusercontent.com/nawafalqari/azkar-api/56df51279ab6eb86dc2f6202c7de26c8948331c1/azkar.json',
        options: Options(responseType: ResponseType.plain),
      );

      if (response.data == null) {
        throw Exception('لا توجد بيانات من الخادم');
      }

      final jsonData = json.decode(response.data as String);
      return jsonData as Map<String, dynamic>;
    } on SocketException {
      throw Exception('لا يوجد اتصال بالإنترنت\nتأكد من اتصالك بالشبكة');
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('انتهت مهلة الاتصال\nتأكد من سرعة الإنترنت');
        case DioExceptionType.sendTimeout:
          throw Exception('انتهت مهلة الإرسال\nحاول مرة أخرى');
        case DioExceptionType.receiveTimeout:
          throw Exception('انتهت مهلة الاستقبال\nحاول مرة أخرى');
        case DioExceptionType.badResponse:
          throw Exception(
            'خطأ من الخادم (${e.response?.statusCode})\nحاول مرة أخرى لاحقاً',
          );
        case DioExceptionType.cancel:
          throw Exception('تم إلغاء الطلب');
        case DioExceptionType.connectionError:
          throw Exception('فشل الاتصال بالخادم\nتحقق من اتصالك بالإنترنت');
        default:
          throw Exception('حدث خطأ غير متوقع\n${e.message}');
      }
    } on FormatException {
      throw Exception('خطأ في تنسيق البيانات\nحاول مرة أخرى');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع\n$e');
    }
  }
}
