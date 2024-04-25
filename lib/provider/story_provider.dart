import 'package:flutter/material.dart';
import 'package:story_app/common/loading_state.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/responses/story_response.dart';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  StoryProvider({required this.apiService, required this.authRepository});

  late StoryResponse _storyResponse;
  StoryResponse get storyResponse => _storyResponse;

  LoadingState storyState = const LoadingState.initial();

  int? pageItems = 1;
  int sizeItems = 5;

  List<ListStory> stories = [];

  Future<void> fetchAllStory() async {
    try {
      if (pageItems == 1) {
        storyState = const LoadingState.loading();
        notifyListeners();
      }

      final repository = await authRepository.getUser();
      final token = repository?.token;
      debugPrint('Token: $token');

      if (token != null) {
        final result = await apiService.listStory(
            token: token, page: pageItems!, size: sizeItems);
        if (result.listStory.isEmpty) {
          storyState = const LoadingState.error('No data returned from API');
        } else {
          stories.addAll(result.listStory);

          storyState = const LoadingState.loaded();

          if (result.listStory.length < sizeItems) {
            pageItems = null;
          } else {
            pageItems = pageItems! + 1;
          }
        }
      } else {
        storyState = const LoadingState.error('No data returned from API');
      }
    } catch (e) {
      storyState = LoadingState.error('Error: $e');
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  Future<void> refreshStory() async {
    pageItems = 1;
    stories.clear();
    await fetchAllStory();
  }
}
