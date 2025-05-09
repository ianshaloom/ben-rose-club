import 'package:dio/dio.dart';

/// Custom exception class to handle various Firebase authentication-related errors.
class C3DioException implements Exception {
  /// The error code associated with the exception.
  final DioExceptionType code;

  /// Additional details about the error.
  final String details;

  /// The response from the server.
  final Map<String, dynamic> response;

  /// Constructor that takes an error code.
  C3DioException(this.code, {this.details = '', this.response = const {}});

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case DioExceptionType.connectionTimeout:
        return 'Connection to server timed out.';
      case DioExceptionType.sendTimeout:
        return 'Server is taking too long to respond.';
      case DioExceptionType.badCertificate:
        return 'Invalid server certificate. \nMore details: \n$details.';
      case DioExceptionType.badResponse:
        final String error = response['error'] ?? 'No error message provided.';
        return 'Server responded with an error. \nError: ${newErrorMessage(error)}';
      case DioExceptionType.cancel:
        return 'Request to server was cancelled. \nMore details: \n$details.';
      case DioExceptionType.connectionError:
        return 'An error occurred while connecting to the server. \nMore details: \n$details.';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred. \nMore details: \n$details.';
      default:
        return 'An unknown error occurred. \nMore details: \n$details.';
    }
  }
}

/// return a [String]
String newErrorMessage(String errorMessage) {
  // Example implementation: remove "Exception: ' from error message
  return errorMessage.replaceAll("Exception: ", "");
}
