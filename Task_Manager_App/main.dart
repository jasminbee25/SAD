import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'dashboard.dart';
import 'task_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://ursyaddxmmtmaykawgmx.supabase.co',
    anonKey: 'sb_publishable_L2onq1RZFJwMWnLBBZuSpw_730XNAYO',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academic Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const Dashboard(),
        '/taskForm': (context) => const TaskForm(),
      },
    );
  }
}