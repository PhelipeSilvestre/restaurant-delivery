import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_delivery/config/routes/app_router.dart';
import 'package:restaurant_delivery/core/utils/dependency_injection.dart';
import 'package:restaurant_delivery/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('Starting app initialization...');

  // Inicializar dependências com tratamento de erro detalhado
  try {
    await setupDependencies();

    // Verificar se as dependências críticas estão disponíveis
    bool dependenciesOK = verifyCoreDependencies();

    if (dependenciesOK) {
      debugPrint('Dependencies OK, starting app...');
      runApp(MyApp());
    } else {
      debugPrint('Core dependencies missing, showing error page');
      runApp(
        ErrorApp(error: 'Falha na inicialização das dependências básicas'),
      );
    }
  } catch (e, stackTrace) {
    debugPrint('Failed to initialize app: $e');
    debugPrint('Stack trace: $stackTrace');
    runApp(ErrorApp(error: e.toString()));
  }
}

class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 80),
                const SizedBox(height: 16),
                const Text(
                  'Erro na inicialização',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(error, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                const Text(
                  'Por favor, verifique o console para mais detalhes',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    main();
                  },
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('Building MyApp...');

    // Usar tryGetIt para obter o AuthBloc de forma segura
    final authBloc = tryGetIt<AuthBloc>();
    if (authBloc == null) {
      debugPrint('AuthBloc is not available, showing fallback UI');
      // Mostrar uma UI de fallback se o AuthBloc não estiver disponível
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text('Inicializando componentes...'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    main(); // Tentar reiniciar o app
                  },
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    debugPrint('Got AuthBloc instance, building full app UI');

    return BlocProvider<AuthBloc>(
      create: (context) => authBloc,
      child: MaterialApp.router(
        title: 'Restaurant Delivery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: AppRouter.getRouter(),
      ),
    );
  }
}
