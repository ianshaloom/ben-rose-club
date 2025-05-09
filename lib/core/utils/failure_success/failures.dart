

import 'failure_n_success.dart';

/// Failure for Firebase Storage operations
class FSFailure extends Failure {
  FSFailure({required super.errorMessage});
}

/// Failure for Dio operations
class DioFailure extends Failure {
  DioFailure({required super.errorMessage});
}