import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> execute({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    debugPrint('RegisterUser usecase: Executing register for: $email');
    return await repository.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
