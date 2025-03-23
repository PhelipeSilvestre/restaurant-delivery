import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_delivery/app/app.dart';
import 'package:restaurant_delivery/core/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carregar variáveis de ambiente
  await dotenv.load(fileName: ".env");

  // Inicializar injeção de dependência
  await setupDependencies();

  runApp(const RestaurantApp());
}
