import 'package:dio/dio.dart';

const String kBaseUrlConterA = 'https://benroseca.fugitechnologies.com';
const String kBaseUrlConterB = 'https://benrosecb.fugitechnologies.com';
const String kBaseUrlConterC = 'https://benrosecc.fugitechnologies.com';

// shop1 dio
final shop1Dio = Dio(options);
final shop2Dio = Dio(options2);

final options = BaseOptions(
  baseUrl: kBaseUrlConterA,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  contentType: 'application/json',
);

final options2 = BaseOptions(
  baseUrl: kBaseUrlConterB,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  contentType: 'application/json',
);
