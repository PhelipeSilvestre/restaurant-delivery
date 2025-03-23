import 'package:get_it/get_it.dart';
import 'package:restaurant_delivery/data/datasources/remote/api_service.dart';
import 'package:restaurant_delivery/data/repositories/auth_repository_impl.dart';
import 'package:restaurant_delivery/data/repositories/product_repository_impl.dart';
import 'package:restaurant_delivery/domain/repositories/auth_repository.dart';
import 'package:restaurant_delivery/domain/repositories/product_repository.dart';
import 'package:restaurant_delivery/domain/usecases/auth/login_user.dart';
import 'package:restaurant_delivery/domain/usecases/auth/register_user.dart';
import 'package:restaurant_delivery/domain/usecases/products/get_products.dart';
import 'package:restaurant_delivery/presentation/bloc/auth/auth_bloc.dart';
import 'package:restaurant_delivery/presentation/bloc/product/product_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Serviços externos
  sl.registerLazySingleton(() => ApiService());

  // Repositórios
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(apiService: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => GetProducts(sl()));

  // BLoCs
  sl.registerFactory(() => AuthBloc(loginUser: sl(), registerUser: sl()));

  sl.registerFactory(() => ProductBloc(getProducts: sl()));
}
