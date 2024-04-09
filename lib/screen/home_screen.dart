import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: FutureBuilder(
        future: AuthRepository().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.data == null) {
            return ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/login');
              },
              child: const Text('Login'),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().logout();
                GoRouter.of(context).go('/login');
              },
              child: const Text('Logout'),
            );
          }
        },
      )),
    );
  }
}
