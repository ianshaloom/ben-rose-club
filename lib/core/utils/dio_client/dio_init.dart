import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioInit extends GetxController {
  static DioInit get instance => Get.find();

  final Dio _dio = Dio();
  Dio get dio => _dio;

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void onInit() {
    _dio.options.connectTimeout = Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = Duration(milliseconds: 30000);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.validateStatus = (_) => true;
        return handler.next(options);
      },
    ));

    super.onInit();
  }
}

