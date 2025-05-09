abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

abstract class Success {
  final String successContent;

  const Success({required this.successContent});
}

class FailureMessage extends Failure {
  const FailureMessage({required super.errorMessage});
}

class SuccessMessage extends Success {
  const SuccessMessage({required super.successContent});
}
