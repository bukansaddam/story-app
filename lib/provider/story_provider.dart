import 'dart:math';

import 'package:flutter/material.dart';
import 'package:story_app/common/result_state.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/responses/story_response.dart';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  StoryProvider({required this.apiService, required this.authRepository}) {
    _fetchAllStory();
  }

  late StoryResponse _storyResponse;
  StoryResponse get storyResponse => _storyResponse;

  late ResultState _state;
  ResultState get state => _state;

  String? _message;
  String? get message => _message;

  Future<dynamic> _fetchAllStory() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final repository = await authRepository.getUser();
      final token = repository?.token;
      debugPrint('Token: $token');

      if (token != null) {
        final stories = await apiService.listStory(token: token);
        if (stories.listStory.isEmpty) {
          _state = ResultState.noData;
        } else {
          _state = ResultState.hasData;
          _storyResponse = stories;
        }
      } else {
        _state = ResultState.error;
        _message = 'No data returned from API';
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      debugPrint(e.toString());
    }
    notifyListeners();
  }
}
