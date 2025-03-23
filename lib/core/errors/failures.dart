// TODO Implement this library.
class ServerFeilure extends Failure {
  @override
  final String message;

  ServerFeilure({required this.message}) : super(message: 'Server Failure');
}

class Failure {
  final String message;

  Failure({required this.message});
}
