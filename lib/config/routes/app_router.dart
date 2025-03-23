import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_delivery/presentation/pages/auth/login_page.dart';
import 'package:restaurant_delivery/presentation/pages/auth/register_page.dart';
import 'package:restaurant_delivery/presentation/pages/cart/cart_page.dart';
import 'package:restaurant_delivery/presentation/pages/checkout/checkout_page.dart';
import 'package:restaurant_delivery/presentation/pages/home/home_page.dart';
import 'package:restaurant_delivery/presentation/pages/menu/menu_page.dart';
import 'package:restaurant_delivery/presentation/pages/orders/order_details_page.dart';
import 'package:restaurant_delivery/presentation/pages/orders/orders_page.dart';
import 'package:restaurant_delivery/presentation/pages/profile/profile_page.dart';

class AppRouter {
  // Mudar de late final para static GoRouter? para evitar erro de inicialização dupla
  static GoRouter? _router;

  static void setupRouter() {
    // Apenas inicialize se ainda não estiver inicializado
    if (_router != null) return;

    _router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/menu', builder: (context, state) => const MenuPage()),
        GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const CheckoutPage(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: '/orders/:id',
          builder:
              (context, state) =>
                  OrderDetailsPage(orderId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
      // Adicionar tratamento de erros para navegação
      errorBuilder:
          (context, state) => const Scaffold(
            body: Center(child: Text('Página não encontrada')),
          ),
    );

    // Registrar no GetIt se ainda não estiver registrado
    if (!GetIt.I.isRegistered<GoRouter>()) {
      GetIt.I.registerSingleton<GoRouter>(_router!);
    }
  }

  static GoRouter getRouter() {
    // Inicializar o router se ainda não foi feito
    if (_router == null) {
      setupRouter();
    }
    return _router!;
  }
}
