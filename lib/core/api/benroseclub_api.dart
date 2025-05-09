import 'package:dartz/dartz.dart';

import '../utils/dio_client/dio_helper.dart';
import '../utils/dio_client/dio_init.dart';
import '../utils/failure_success/failure_n_success.dart';
import '../utils/failure_success/failures.dart';

class API {
  /// Get data
  static Future<Either<Failure, Map<String, dynamic>>> counterA(
    String date,
  ) async {
    // change the base url
    DioInit.instance.setBaseUrl('http://192.168.0.103:8882');

    try {
      final response = await DioHelper.get(
        '/v2/transaction',
        queryParameters: {'date': date},
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] as String;

        // remove "Exception: " from error message
        final error = newErrorMessage(errorMessage);

        return Left(DioFailure(errorMessage: error));
      }

      final data = await response.data as Map<String, dynamic>;

      return Right(data);
    } catch (e) {
      final errorMessage = e.toString();

      // route not found error
      if (errorMessage == routeNotFoundError) {
        return Left(
          DioFailure(errorMessage: 'EndPoint Route Not Found: $errorMessage'),
        );
      }

      return Left(
        DioFailure(errorMessage: 'Failed to fetch data: $errorMessage'),
      );
    }
  }

  /// Get data
  static Future<Either<Failure, Map<String, dynamic>>> counterB(
    String date,
  ) async {
    // change the base url
    DioInit.instance.setBaseUrl('http://192.168.0.103:8080');

    try {
      final response = await DioHelper.get(
        '/v2/transaction',
        queryParameters: {'date': date},
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] as String;

        // remove "Exception: " from error message
        final error = newErrorMessage(errorMessage);

        return Left(DioFailure(errorMessage: error));
      }

      final data = await response.data as Map<String, dynamic>;

      return Right(data);
    } catch (e) {
      final errorMessage = e.toString();

      // route not found error
      if (errorMessage == routeNotFoundError) {
        return Left(
          DioFailure(errorMessage: 'EndPoint Route Not Found: $errorMessage'),
        );
      }

      return Left(
        DioFailure(errorMessage: 'Failed to fetch data: $errorMessage'),
      );
    }
  }

  /// Get data
  static Future<Either<Failure, Map<String, dynamic>>> counterC(
    String date,
  ) async {
    // change the base url
    DioInit.instance.setBaseUrl('http://192.168.0.103:8080');

    try {
      final response = await DioHelper.get(
        '/v2/transaction',
        queryParameters: {'date': date},
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] as String;

        // remove "Exception: " from error message
        final error = newErrorMessage(errorMessage);

        return Left(DioFailure(errorMessage: error));
      }

      final data = await response.data as Map<String, dynamic>;

      return Right(data);
    } catch (e) {
      final errorMessage = e.toString();

      // route not found error
      if (errorMessage == routeNotFoundError) {
        return Left(
          DioFailure(errorMessage: 'EndPoint Route Not Found: $errorMessage'),
        );
      }

      return Left(
        DioFailure(errorMessage: 'Failed to fetch data: $errorMessage'),
      );
    }
  }
}

/// return a [String]
String newErrorMessage(String errorMessage) {
  // Example implementation: remove "Exception: ' from error message
  return errorMessage.replaceAll("Exception: ", "");
}

/// route not found error
const String routeNotFoundError =
    "type 'String' is not a subtype of type 'int' of 'index'";
