import 'package:dartz/dartz.dart';

import '../../features/sales/models/transaction.dart';
import '../utils/dio_client/dio_helper.dart';
import '../utils/dio_client/dio_init.dart';
import '../utils/failure_success/failure_n_success.dart';
import '../utils/failure_success/failures.dart';

class API {
  /// Get data
  static Future<Either<Failure, List<Transaction>>> counterA(
    String date, {
    required String filterType,
    String? startDate,
    String? endDate,
  }) async {
    // get dio
    final dio = DioInit.instance.dio('A');

    try {
      switch (filterType) {}

      final response = await DioHelper.get(
        '/v2/transaction',
        queryParameters: {
          'filterType': filterType,
          'date': date,
          'startDate': startDate,
          'endDate': endDate,
        },
        dio: dio,
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] as String;

        // remove "Exception: " from error message
        final error = newErrorMessage(errorMessage);

        return Left(DioFailure(errorMessage: error));
      }

      final resp = await response.data;
      final data = resp['data'] as List;

      final List<Transaction> transactions =
          (data).map((e) => Transaction.fromJson(e)).toList();

      return Right(transactions);
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
  static Future<Either<Failure, List<Transaction>>> counterB(
    String date,
  ) async {
    // get dio
    final dio = DioInit.instance.dio('B');

    try {
      final response = await DioHelper.get(
        '/v2/transaction',
        queryParameters: {'date': date},
        dio: dio,
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] as String;

        // remove "Exception: " from error message
        final error = newErrorMessage(errorMessage);

        return Left(DioFailure(errorMessage: error));
      }

      final data = await response.data;

      final List<Transaction> transactions =
          (data as List).map((e) => Transaction.fromJson(e)).toList();

      return Right(transactions);
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
  static Future<Either<Failure, List<Transaction>>> counterC(
    String date,
  ) async {
    // get dio
    final dio = DioInit.instance.dio('C');

    try {
      final response = await DioHelper.get(
        '/v2/transaction',
        queryParameters: {'date': date},
        dio: dio,
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] as String;

        // remove "Exception: " from error message
        final error = newErrorMessage(errorMessage);

        return Left(DioFailure(errorMessage: error));
      }

      final data = await response.data;

      final List<Transaction> transactions =
          (data as List).map((e) => Transaction.fromJson(e)).toList();

      return Right(transactions);
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
