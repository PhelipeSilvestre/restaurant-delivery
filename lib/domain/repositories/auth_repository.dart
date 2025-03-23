import 'package:dartz/dartz.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  Future<void> logout();
}
