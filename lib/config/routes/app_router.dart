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
  static final GoRouter router = GoRouter(
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
      GoRoute(path: '/orders', builder: (context, state) => const OrdersPage()),
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
  );
}
