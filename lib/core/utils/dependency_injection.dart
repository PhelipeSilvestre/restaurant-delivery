import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_delivery/data/datasources/database.dart';
import 'package:restaurant_delivery/data/datasources/remote/api_service.dart';
import 'package:restaurant_delivery/data/repositories/auth_repository_impl.dart';
import 'package:restaurant_delivery/data/repositories/product_repository_impl.dart';
import 'package:restaurant_delivery/data/repositories/user_repository.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';
import 'package:restaurant_delivery/domain/repositories/product_repository.dart';
import 'package:restaurant_delivery/domain/usecases/auth/login_user.dart';
import 'package:restaurant_delivery/domain/usecases/auth/register_user.dart';
import 'package:restaurant_delivery/domain/usecases/products/get_products.dart';
import 'package:restaurant_delivery/presentation/bloc/auth/auth_bloc.dart';
import 'package:restaurant_delivery/presentation/bloc/product/product_bloc.dart';
import 'package:hive/hive.dart';

final GetIt sl = GetIt.instance;
bool _isInitialized = false;

// Função de verificação segura para GetIt
T? tryGetIt<T extends Object>() {
  try {
    if (sl.isRegistered<T>()) {
      return sl<T>();
    }
  } catch (e) {
    debugPrint('Error getting $T: $e');
  }
  return null;
}

Future<void> setupDependencies() async {
  if (_isInitialized) {
    debugPrint('Dependencies already initialized');
    return;
  }

  try {
    debugPrint('Starting dependency initialization...');

    // Inicializar Hive Box para dados simples
    debugPrint('Opening Hive box for app storage...');
    final box = await Hive.openBox('app_storage'); // Cria ou abre a caixa
    sl.registerLazySingleton<Box>(() => box); // Registra a caixa no GetIt

    // Serviços externos - inicialização baseada na plataforma
    await _initializePlatformDependentServices();

    // Repositórios
    debugPrint('Registering repositories...');
    _initializeRepositories();

    // Use cases
    debugPrint('Registering use cases...');
    _initializeUseCases();

    // BLoCs
    debugPrint('Registering BLoCs...');
    _initializeBlocs();

    _isInitialized = true;
    debugPrint('Dependency injection setup completed successfully');
  } catch (e, stackTrace) {
    debugPrint('Error during dependency initialization: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
  }
}

// Inicializa serviços que dependem da plataforma
Future<void> _initializePlatformDependentServices() async {
  try {
    debugPrint('Registering ApiService...');
    final apiService = await ApiService.create();
    sl.registerLazySingleton<ApiService>(() => apiService);

    debugPrint('Initializing Database...');
    final db = Database();
    await db.connect();
    sl.registerLazySingleton(() => db);
  } catch (e) {
    debugPrint('Error initializing platform services: $e');
    rethrow;
  }
}

// Inicializa os repositórios
void _initializeRepositories() {
  try {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: sl<ApiService>()),
    );

    // Registre o UserRepository de forma segura, sem cast
    sl.registerLazySingleton(
      () => UserRepository(sl<ApiService>(), sl<Database>()),
    );

    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(apiService: sl<ApiService>()),
    );
  } catch (e) {
    debugPrint('Error initializing repositories: $e');
    rethrow;
  }
}

// Inicializa os casos de uso
void _initializeUseCases() {
  try {
    sl.registerLazySingleton(() => LoginUser(sl<AuthRepository>()));
    sl.registerLazySingleton(() => RegisterUser(sl<AuthRepository>()));
    sl.registerLazySingleton(() => GetProducts(sl<ProductRepository>()));
  } catch (e) {
    debugPrint('Error initializing use cases: $e');
    rethrow;
  }
}

// Inicializa os BLoCs
void _initializeBlocs() {
  try {
    sl.registerFactory(() {
      final loginUser = sl<LoginUser>();
      final registerUser = sl<RegisterUser>();
      debugPrint('Creating AuthBloc with login and register use cases');
      return AuthBloc(loginUser: loginUser, registerUser: registerUser);
    });

    sl.registerFactory(
      () => ProductBloc(
        getProducts: sl<GetProducts>(),
        productRepository: sl<ProductRepository>(),
      ),
    );
  } catch (e) {
    debugPrint('Error initializing BLoCs: $e');
    rethrow;
  }
}

// Verificação das dependências principais
bool verifyCoreDependencies() {
  try {
    debugPrint('Verifying core dependencies...');

    // Verificar ApiService
    final apiService = tryGetIt<ApiService>();
    if (apiService == null) {
      debugPrint('❌ ApiService is not registered!');
      return false;
    }
    debugPrint('✓ ApiService is correctly registered');

    // Verificar repositórios
    final authRepo = tryGetIt<AuthRepository>();
    if (authRepo == null) {
      debugPrint('❌ AuthRepository is not registered!');
      return false;
    }
    debugPrint('✓ AuthRepository is correctly registered');

    // Verificar use cases
    final loginUseCase = tryGetIt<LoginUser>();
    if (loginUseCase == null) {
      debugPrint('❌ LoginUser use case is not registered!');
      return false;
    }
    debugPrint('✓ LoginUser use case is correctly registered');

    // Verificar BLoCs
    final authBloc = tryGetIt<AuthBloc>();
    if (authBloc == null) {
      debugPrint('❌ AuthBloc is not registered!');
      return false;
    }
    debugPrint('✓ AuthBloc is correctly registered');

    return true;
  } catch (e) {
    debugPrint('Error verifying dependencies: $e');
    return false;
  }
}
