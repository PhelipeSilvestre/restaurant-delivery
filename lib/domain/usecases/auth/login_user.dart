import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, User>> execute({
    required String email,
    required String password,
  }) async {
    debugPrint('LoginUser usecase: Executing login for: $email');
    return await repository.login(email: email, password: password);
  }
}
