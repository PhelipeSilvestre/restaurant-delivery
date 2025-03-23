// TODO Implement this library.

// Custom exception classes
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message = "Unauthorized access."]);

  @override
  String toString() => "UnauthorizedException: $message";
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException([this.message = "Resource not found."]);

  @override
  String toString() => "NotFoundException: $message";
}

class ServerException implements Exception {
  final String message;

  ServerException([this.message = "Server error occurred."]);

  @override
  String toString() => "ServerException: $message";
}

class RequestCancelledException implements Exception {
  final String message;

  RequestCancelledException([this.message = "Request was cancelled."]);

  @override
  String toString() => "RequestCancelledException: $message";
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = "An unknown network error occurred."]);

  @override
  String toString() => "NetworkException: $message";
}
