import 'package:dartz/dartz.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return await repository.register(user.email, user.name);
  }

  execute({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) {}
}
