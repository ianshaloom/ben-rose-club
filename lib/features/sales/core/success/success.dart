abstract class Success {
  final Map<String, dynamic> successContent;
  const Success({required this.successContent});
}

class ServerSuccess extends Success {
  ServerSuccess({required super.successContent});
}

class CacheSuccess extends Success {
  CacheSuccess({required super.successContent});
}
