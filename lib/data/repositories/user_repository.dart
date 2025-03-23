import 'package:postgres/postgres.dart';
import '../datasources/database.dart';

class UserRepository {
  final PostgreSQLConnection connection = Database().connection;

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await connection.query(
        '''
        INSERT INTO users (name, email, password)
        VALUES (@name, @mail, @pass)
        ''',
        substitutionValues: {'name': name, 'mail': email, 'pass': password},
      );
      print('Usuário criado com sucesso!');
    } catch (e) {
      print('Erro ao criar usuário: $e');
      rethrow;
    }
  }

  Future<List<Map<String, Map<String, dynamic>>>> getUsers() async {
    final result = await connection.mappedResultsQuery('SELECT * FROM users');
    return result;
  }
}
