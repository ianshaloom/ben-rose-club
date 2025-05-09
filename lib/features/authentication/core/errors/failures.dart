abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class AuthFailure extends Failure {
  AuthFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
