import 'package:postgres/postgres.dart';

class Database {
  static final Database _instance = Database._internal();
  late PostgreSQLConnection connection;

  factory Database() {
    return _instance;
  }

  Database._internal();

  Future<void> connect() async {
    connection = PostgreSQLConnection(
      'localhost', // Host do banco de dados
      5432, // Porta padrão do PostgreSQL
      'restaurant_delivery', // Nome do banco de dados
      username: 'postgres', // Usuário do banco
      password: '123@Mudar', // Substitua pela senha do PostgreSQL
    );

    await connection.open();
    print('Conexão com o banco de dados estabelecida!');
  }

  Future<void> close() async {
    await connection.close();
    print('Conexão com o banco de dados encerrada!');
  }
}
