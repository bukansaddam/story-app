import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:story_app/data/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/data/model/register.dart';
import 'package:story_app/data/responses/detail_story_response.dart';
import 'package:story_app/data/responses/story_response.dart';
import 'package:story_app/data/responses/upload_response.dart';

class ApiService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';
  static const String _login = '/login';
  static const String _register = '/register';
  static const String _story = '/stories';

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

  Future<StoryResponse> listStory(
      {required String token, int page = 1, int size = 5}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$_story?page=$page&size=$size'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return StoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load story');
    }
  }

  Future<DetailResponse> detailStory(
      {required String id, required String token}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$_story/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return DetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load story');
    }
  }

  Future<UploadResponse> uploadStory(
    List<int> image,
    String description,
    String fileName,
    String token,
    double latitude,
    double longitude,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl$_story'));

    final multiPartFile = http.MultipartFile.fromBytes(
      'photo',
      image,
      filename: fileName,
    );
    final Map<String, String> data = {
      'description': description,
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    };
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    request.files.add(multiPartFile);
    request.fields.addAll(data);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      try {
        final Map<String, dynamic> responseMap = jsonDecode(responseData);
        final UploadResponse uploadResponse =
            UploadResponse.fromJson(responseMap);
        debugPrint('Upload Response: $uploadResponse');
        return uploadResponse;
      } catch (e) {
        throw Exception('Failed to parse upload response: $e');
      }
    } else {
      throw Exception('Failed to upload story');
    }
  }
}
