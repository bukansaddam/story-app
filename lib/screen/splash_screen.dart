import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  delayScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final authRepository = context.read<AuthProvider>().authRepository;
    final isLoggedIn = await authRepository.getState();
    final name = await authRepository.getUser();
    debugPrint('IsLoggedIn: $isLoggedIn, Name: $name');
    if (name == null) {
      context.goNamed('login');
    } else {
      context.goNamed('home');
    }
  }

  @override
  void initState() {
    super.initState();
    delayScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Story App',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
        decoration: TextDecoration.none,
      ),
    ));
  }
}
