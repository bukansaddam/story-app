import 'package:flutter/material.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/model/login.dart';
import 'package:story_app/data/model/register.dart';
import 'package:story_app/data/model/user.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  AuthProvider({required this.apiService, required this.authRepository});

  bool isLoadingLogin = false;
  bool isLoadingRegister = false;
  bool isLoadingLogout = false;
  bool isLoggedIn = false;
  bool isRegistered = false;

  String? errorMessageLogin;
  String? errorMessageRegister;

  Future<bool> login(String email, String password) async {
    isLoadingLogin = true;
    notifyListeners();

    try {
      final LoginResponse loginResponse =
          await apiService.login(email: email, password: password);
      if (loginResponse.error) {
        errorMessageLogin = loginResponse.message;
      } else {
        final User user = User(
          name: loginResponse.loginResult.name,
          token: loginResponse.loginResult.token,
        );
        await authRepository.saveUser(user);
        debugPrint('User: ${user.toJson()}');
        await authRepository.saveState(true);
      }
    } catch (e) {
      errorMessageLogin = e.toString();
    }

    isLoggedIn = await authRepository.getState();
    notifyListeners();

    debugPrint('IsLoggedIn: $isLoggedIn');

    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> register(String name, String email, String password) async {
    isLoadingRegister = true;
    notifyListeners();

    try {
      final RegisterResponse registerResponse = await apiService.register(
          name: name, email: email, password: password);
      if (registerResponse.error) {
        errorMessageRegister = registerResponse.message;
      } else {
        isRegistered = true;
        notifyListeners();
      }
    } catch (e) {
      errorMessageRegister = e.toString();
    }

    isLoadingRegister = false;
    notifyListeners();

    return isRegistered;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    try {
      await authRepository.deleteUser();
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoggedIn = await authRepository.saveState(false);
    notifyListeners();

    isLoadingLogout = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<User?> getUser() async {
    return await authRepository.getUser();
  }

  Future<String> getToken() async {
    final User? user = await authRepository.getUser();
    return user?.token ?? '';
  }

  Future<bool> checkLogin() async {
    isLoggedIn = await authRepository.getState();
    notifyListeners();
    return isLoggedIn;
  }
}
