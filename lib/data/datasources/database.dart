import 'package:postgres/postgres.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' as io;

class Database {
  static final Database _instance = Database._internal();
  PostgreSQLConnection? _connection;
  bool _isInitialized = false;
  bool _isWebPlatform = true;

  factory Database() {
    return _instance;
  }

  Database._internal() {
    // Verifica se está rodando na web
    try {
      _isWebPlatform = kIsWeb;
      debugPrint('Detectada plataforma: ${_isWebPlatform ? 'Web' : 'Nativa'}');
    } catch (e) {
      debugPrint('Erro ao detectar plataforma: $e');
      _isWebPlatform = true; // Assume web para ser seguro
    }
  }

  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('Conexão já inicializada, ignorando chamada repetida');
      return;
    }

    if (_isWebPlatform) {
      debugPrint('Ambiente web detectado: PostgreSQL direto não é suportado.');
      debugPrint('Usando Supabase API em vez de PostgreSQL direto.');
      _isInitialized = true;
      return;
    }

    try {
      debugPrint('Inicializando conexão PostgreSQL...');
      _connection = PostgreSQLConnection(
        'zldomhmzxdjguoeqjtan.supabase.co', // host
        5432, // port
        'postgres', // databaseName
        username: 'postgres',
        password: '123@Mudar',
        useSSL: true,
      );

      await _connection!.open();
      _isInitialized = true;
      debugPrint('Conexão PostgreSQL inicializada com sucesso!');
    } catch (e) {
      debugPrint('Erro ao inicializar conexão PostgreSQL: $e');
      _isInitialized = false;
      rethrow;
    }
  }

  PostgreSQLConnection get connection {
    if (_isWebPlatform) {
      throw UnsupportedError(
        'Conexão PostgreSQL direta não é suportada na Web. Use Supabase API.',
      );
    }
    if (!_isInitialized || _connection == null || _connection!.isClosed) {
      throw Exception(
        'Conexão PostgreSQL não está aberta. Chame connect() primeiro.',
      );
    }
    return _connection!;
  }

  Future<PostgreSQLConnection?> connect() async {
    if (_isWebPlatform) {
      debugPrint('Ambiente web: Ignorando conexão PostgreSQL direta');
      _isInitialized = true;
      return null;
    }

    if (_isInitialized && _connection != null && !_connection!.isClosed) {
      debugPrint('Reutilizando conexão PostgreSQL existente');
      return _connection;
    }

    debugPrint('Estabelecendo conexão com PostgreSQL via connect()');
    await initialize();
    return _connection;
  }

  Future<void> close() async {
    if (!_isWebPlatform &&
        _isInitialized &&
        _connection != null &&
        !_connection!.isClosed) {
      debugPrint('Fechando conexão PostgreSQL');
      await _connection!.close();
    }
    _isInitialized = false;
  }

  bool get isWebPlatform => _isWebPlatform;
}
