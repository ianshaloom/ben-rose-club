import 'package:dio/dio.dart';

import 'dio_exceptions.dart';

class DioHelper {
  // get method
  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required Dio dio,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
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
