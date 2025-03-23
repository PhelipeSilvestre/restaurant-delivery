import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_delivery/core/errors/exceptions.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late final Dio _dio;

  // Factory constructor para criar a instância apropriada
  static Future<ApiService> create() async {
    try {
      debugPrint(
        'Creating ApiService for platform: ${kIsWeb ? 'Web' : 'Native'}',
      );

      // Aqui você pode implementar lógica específica dependendo da plataforma
      final service = ApiService._();
      await service._initialize();
      return service;
    } catch (e) {
      debugPrint('Error creating ApiService: $e');
      rethrow;
    }
  }

  // Construtor privado
  ApiService._();

  // Estado de inicialização
  bool _initialized = false;

  // Método para inicialização assíncrona
  Future<void> _initialize() async {
    try {
      if (_initialized) return;

      // Configuração específica da plataforma
      if (kIsWeb) {
        await _initializeForWeb();
      } else {
        await _initializeForNative();
      }

      _initialized = true;
      debugPrint('ApiService initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize ApiService: $e');
      rethrow;
    }
  }

  // Inicialização para web
  Future<void> _initializeForWeb() async {
    // Implementar inicialização específica para web
    debugPrint('Initializing ApiService for Web platform');
    // Exemplo: configurar REST client ou Firebase para web
  }

  // Inicialização para plataformas nativas
  Future<void> _initializeForNative() async {
    // Implementar inicialização específica para mobile
    debugPrint('Initializing ApiService for Native platform');
    // Exemplo: configurar client nativo, SQLite, etc.
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors para logging, tokens, etc.
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Adicionar token de autenticação se disponível
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (error, handler) {
          // Tratamento de erro global
          return handler.next(error);
        },
      ),
    );
  }

  // Métodos de API
  // Implemente aqui métodos para comunicação com o backend
  // Exemplos: login, register, getProducts, etc.

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      debugPrint('Attempting login for: $email');
      // Implementação de login simulado para teste
      await Future.delayed(Duration(seconds: 1));
      return {
        'success': true,
        'user': {'id': '123', 'email': email, 'name': 'Test User'},
      };
    } catch (e) {
      debugPrint('Login error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    try {
      debugPrint('Attempting registration for: $email');
      // Implementação de registro simulado para teste
      await Future.delayed(Duration(seconds: 1));
      return {
        'success': true,
        'user': {'id': '123', 'email': email, 'name': name, 'phone': phone},
      };
    } catch (e) {
      debugPrint('Registration error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Timeout na conexão com o servidor');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Erro no servidor';

        if (statusCode == 401) {
          throw UnauthorizedException(message);
        } else if (statusCode == 404) {
          throw NotFoundException(message);
        } else {
          throw ServerException(message);
        }
      case DioExceptionType.cancel:
        throw RequestCancelledException('Requisição cancelada');
      default:
        throw NetworkException('Sem conexão com a internet');
    }
  }

  createUser(Map<String, String> userData) {}

  logout() {}
}
