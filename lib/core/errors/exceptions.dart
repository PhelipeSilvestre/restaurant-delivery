// TODO Implement this library.

// Custom exception classes
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => "UnauthorizedException: $message";
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => "NotFoundException: $message";
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => "ServerException: $message";
}

class RequestCancelledException implements Exception {
  final String message;

  RequestCancelledException(this.message);

  @override
  String toString() => "RequestCancelledException: $message";
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => "NetworkException: $message";
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => "CacheException: $message";
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => "AuthException: $message";
}
