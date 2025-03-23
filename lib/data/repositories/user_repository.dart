import 'package:restaurant_delivery/data/datasources/database.dart';
import 'package:restaurant_delivery/data/datasources/remote/api_service.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  final ApiService _apiService;
  final Database _database;

  UserRepository(this._apiService, this._database);

  Future<void> initializePostgres() async {
    if (_database.isWebPlatform) {
      debugPrint('Ambiente web detectado: Usando apenas Supabase API');
      return;
    }

    try {
      await _database.connect();
      debugPrint('Postgres inicializado no UserRepository');
    } catch (e) {
      debugPrint('Erro ao inicializar Postgres no UserRepository: $e');
    }
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint('Criando usuário: $email');

    // Criar usuário no Supabase independentemente da plataforma
    try {
      final userData = {'name': name, 'email': email};

      final response = await _apiService.createUser(userData);

      if (response['error'] != null) {
        throw Exception(
          'Erro ao criar usuário no Supabase: ${response['error']}',
        );
      }

      debugPrint('Usuário criado com sucesso no Supabase!');
    } catch (e) {
      debugPrint('Erro ao criar usuário no Supabase: $e');
      rethrow;
    }

    // Criar usuário no PostgreSQL apenas se não estiver no web
    if (!_database.isWebPlatform) {
      try {
        await _database.connection.query(
          '''
          INSERT INTO users (name, email, password)
          VALUES (@name, @mail, @pass)
          ''',
          substitutionValues: {'name': name, 'mail': email, 'pass': password},
        );
        debugPrint('Usuário também criado no PostgreSQL direto!');
      } catch (e) {
        debugPrint('Erro ao criar usuário no PostgreSQL: $e');
        // Não lançamos exceção para não impedir o fluxo se Supabase já funcionou
      }
    }
  }

  Future<List<Map<String, Map<String, dynamic>>>> getUsers() async {
    if (_database.isWebPlatform) {
      debugPrint('Postgres não está habilitado, retornando lista vazia');
      return [];
    }

    final result = await _database.connection.mappedResultsQuery(
      'SELECT * FROM users',
    );
    return result;
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    try {
      debugPrint('UserRepository: Attempting registration for: $email');
      final response = await _apiService.register(name, email, password, phone);

      if (response['success'] == true) {
        debugPrint('UserRepository: Registration successful');
        return response;
      } else {
        throw Exception(response['error'] ?? 'Registration failed');
      }
    } catch (e) {
      debugPrint('UserRepository registration error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      debugPrint('UserRepository: Attempting login for: $email');
      final response = await _apiService.login(email, password);

      if (response['success'] == true) {
        debugPrint('UserRepository: Login successful');
        // Salvar dados do usuário localmente se necessário
        return response;
      } else {
        throw Exception(response['error'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint('UserRepository login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    debugPrint('Fazendo logout');
    await _apiService.logout();
    debugPrint('Logout realizado com sucesso');
  }
}
