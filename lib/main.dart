import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_delivery/app/app.dart';
import 'package:restaurant_delivery/core/utils/dependency_injection.dart';
import 'package:restaurant_delivery/data/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carregar variáveis de ambiente
  await dotenv.load(fileName: ".env");

  // Inicializar injeção de dependência
  await setupDependencies();

  await Supabase.initialize(
    url: 'https://zldomhmzxdjguoeqjtan.supabase.co',
    // Substitua pelo URL do seu projeto
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpsZG9taG16eGRqZ3VvZXFqdGFuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI3NTI3NzIsImV4cCI6MjA1ODMyODc3Mn0.Ro-EUHD69EUx5i_zJDE0VHUk_rm6Qrk-zFbYqhkWqGM', // Substitua pela chave anônima do seu projeto
  );

  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepository = GetIt.I<UserRepository>();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Supabase Test')),
        body: const Center(child: Text('Supabase configurado com sucesso!')),
      ),
    );
  }
}
