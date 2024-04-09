import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:story_app/data/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/data/model/register.dart';

class ApiService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';
  static const String _login = '/login';
  static const String _register = '/register';

  Future<LoginResponse> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _login),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponse> register(
      {required String name,
      required String email,
      required String password}) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _register),
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
      throw Exception('Failed to register');
    }
  }
}
