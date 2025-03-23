import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  late SupabaseClient _client;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  SupabaseClient get client {
    if (!_isInitialized) {
      throw Exception(
        'Supabase não inicializado! Chame initialize() primeiro.',
      );
    }
    return _client;
  }

  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('Supabase já inicializado, ignorando chamada repetida');
      return;
    }

    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (url == null || anonKey == null) {
      throw Exception(
        'Variáveis de ambiente do Supabase não foram encontradas. Verifique o arquivo .env',
      );
    }

    debugPrint('Inicializando Supabase...');
    await Supabase.initialize(url: url, anonKey: anonKey);
    _client = Supabase.instance.client;
    _isInitialized = true;
    debugPrint('Supabase inicializado com sucesso!');
  }
}
