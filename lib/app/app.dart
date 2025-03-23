import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_delivery/app/theme/app_theme.dart';
import 'package:restaurant_delivery/config/routes/app_router.dart';
import 'package:restaurant_delivery/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => GetIt.I<AuthBloc>()),
        // Outros BloCs serão adicionados aqui
      ],
      child: MaterialApp.router(
        title: 'Restaurante Delivery',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
