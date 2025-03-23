import 'package:dartz/dartz.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';

abstract class AuthRepository {
  Future login(String email, String password);
  Future<void> logout();
  Future<Either<Failure, User>> register(String email, String password);
  Future<bool> isSignedIn();
  Future<String?> getCurrentUserId();
}
