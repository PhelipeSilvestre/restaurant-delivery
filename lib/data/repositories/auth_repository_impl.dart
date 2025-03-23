import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_delivery/core/errors/exceptions.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';
import 'package:restaurant_delivery/data/datasources/remote/api_service.dart';
import 'package:restaurant_delivery/domain/entities/user.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('AuthRepositoryImpl: Attempting login for: $email');
      final response = await apiService.login(email, password);

      if (response['success'] == true) {
        final userData = response['user'];
        final user = User(
          id: userData['id'] ?? '',
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['phone'],
        );
        debugPrint('AuthRepositoryImpl: Login successful for: $email');
        return Right(user);
      } else {
        debugPrint('AuthRepositoryImpl: Login failed: ${response['error']}');
        return Left(AuthFailure(response['error'] ?? 'Login failed'));
      }
    } on ServerException catch (e) {
      debugPrint('AuthRepositoryImpl: Server exception: ${e.message}');
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      debugPrint('AuthRepositoryImpl: Network exception: ${e.message}');
      return Left(NetworkFailure(e.message));
    } catch (e) {
      debugPrint('AuthRepositoryImpl: Unexpected error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      debugPrint('AuthRepositoryImpl: Attempting register for: $email');
      final response = await apiService.register(name, email, password, phone);

      if (response['success'] == true) {
        final userData = response['user'];
        final user = User(
          id: userData['id'] ?? '',
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['phone'],
        );
        debugPrint('AuthRepositoryImpl: Registration successful for: $email');
        return Right(user);
      } else {
        debugPrint(
          'AuthRepositoryImpl: Registration failed: ${response['error']}',
        );
        return Left(AuthFailure(response['error'] ?? 'Registration failed'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    // Implementar lógica de logout
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
