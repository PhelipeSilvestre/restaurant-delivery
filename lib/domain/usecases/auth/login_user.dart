import 'package:dartz/dartz.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<Either<Failure, User>> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return Left(InvalidInputFailure('Email or password cannot be empty'));
    }
    return await authRepository.login(email, password);
  }

  execute({required String email, required String password}) {}
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure(message) : super(message: '');
}
