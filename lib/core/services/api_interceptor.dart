import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class ApiInterceptor {
  static void initialize() {
    // Aqui você poderia configurar interceptores para requisições HTTP
    // Por exemplo, adicionar logs, manipulação de erros, etc.
    debugPrint('API Interceptor inicializado');
  }

  static void logRequest(
    String method,
    String endpoint,
    Map<String, dynamic>? body,
  ) {
    if (kDebugMode) {
      debugPrint('API Request: $method $endpoint');
      if (body != null) {
        debugPrint('Request Body: $body');
      }
    }
  }

  static void logResponse(dynamic response) {
    if (kDebugMode) {
      if (response is PostgrestResponse) {
        if (response.error != null) {
          debugPrint('API Error: ${response.error!.message}');
        } else {
          debugPrint('API Response: ${response.data}');
        }
      }
    }
  }
}
