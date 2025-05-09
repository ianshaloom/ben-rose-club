abstract class Success {
  final Map<String, dynamic> successContent;
  const Success({required this.successContent});
}

class ServerSuccess extends Success {
  ServerSuccess({required Map<String, dynamic> successContent})
      : super(successContent: successContent);
}

class CacheSuccess extends Success {
  CacheSuccess({required Map<String, dynamic> successContent})
      : super(successContent: successContent);
}
