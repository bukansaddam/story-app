import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/model/user.dart';

class AuthRepository {
  final String stateKey = 'state';
  final String userKey = 'user';

  Future<bool> saveState(bool isLoggedIn) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setBool(stateKey, isLoggedIn);
  }

  Future<bool> getState() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    final jsonString = jsonEncode(user.toJson());
    return preferences.setString(userKey, jsonString);
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, '');
  }

  Future<User?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    final jsonString = preferences.getString(userKey) ?? '';
    User? user;
    try {
      final jsonMap = jsonDecode(jsonString);
      user = User.fromJson(jsonMap);
    } catch (e) {
      user = null;
    }
    return user;
  }
}
