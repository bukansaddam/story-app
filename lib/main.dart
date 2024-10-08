import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/provider/image_provider.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/provider/upload_provider.dart';
import 'package:story_app/screen/add_story_screen.dart';
import 'package:story_app/screen/choose_location.dart';
import 'package:story_app/screen/detail_screen.dart';
import 'package:story_app/screen/home_screen.dart';
import 'package:story_app/screen/login_screen.dart';
import 'package:story_app/screen/maps_screen.dart';
import 'package:story_app/screen/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:story_app/screen/splash_screen.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: 'splash',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
            path: 'add',
            name: 'add_story',
            builder: (context, state) => const AddStoryScreen(),
            routes: [
              GoRoute(
                path: 'choose',
                name: 'choose_location',
                builder: (context, state) => const ChooseLocationScreen(),
              )
            ]),
        GoRoute(
          path: 'detail/:id',
          name: 'detail',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return DetailScreen(id: id!);
          },
        ),
        GoRoute(
          path: 'maps',
          name: 'maps',
          builder: (context, state) => const MapsScreen(),
        ),
      ]),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: 'register',
    builder: (context, state) => const RegisterScreen(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<StoryProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImagesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UploadProvider>(),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData.dark().copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.orange,
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
        ),
        darkTheme: ThemeData.dark(),
        routerConfig: _router,
      ),
    );
  }
}
