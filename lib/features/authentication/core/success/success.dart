abstract class Success {
  final String successContent;
  const Success({required this.successContent});
}

class AuthSuccess extends Success {
  AuthSuccess({required super.successContent});
}
