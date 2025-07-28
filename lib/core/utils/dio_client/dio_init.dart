import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioInit extends GetxController {
  static DioInit init() => Get.put(DioInit(), permanent: true);

  static DioInit get instance => Get.find();

  Dio dio(String counter) {
    switch (counter) {
      case 'A':
        return counterA;
      case 'B':
        return counterB;
      case 'C':
        return counterC;
      default:
        return counterA;
    }
  }

  //  Dio Instances
  late Dio counterA;
  late Dio counterB;
  late Dio counterC;

  final optionsA = BaseOptions(
    baseUrl: 'https://brca.fugitechnologies.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60),
    contentType: 'application/json',
  );

  final optionsB = BaseOptions(
    baseUrl: 'https://brcb.fugitechnologies.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60),
    contentType: 'application/json',
  );

  final optionsC = BaseOptions(
    baseUrl: 'https://brcc.fugitechnologies.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60),
    contentType: 'application/json',
  );

  @override
  void onInit() {
    counterA = Dio(optionsA);
    counterA.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.validateStatus = (_) => true;
          return handler.next(options);
        },
      ),
    );

    counterB = Dio(optionsB);
    counterB.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.validateStatus = (_) => true;
          return handler.next(options);
        },
      ),
    );

    counterC = Dio(optionsC);
    counterC.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.validateStatus = (_) => true;
          return handler.next(options);
        },
      ),
    );

    super.onInit();
  }
}
