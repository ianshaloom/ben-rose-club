import 'package:dio/dio.dart';

import 'dio_exceptions.dart';
import 'dio_init.dart';

class DioHelper {
  static final Dio _dio = DioInit.instance.dio;

  // get method
  static Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
    } on DioException catch (e) {
      throw C3DioException(
        e.type,
        details: e.message ?? 'No detailed information about error.',
        response: e.response?.data ?? {},
      ).message;
    } catch (_) {
      throw 'An unexpected error occurred.';
    }
  }
}
