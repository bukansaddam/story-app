import 'package:flutter/material.dart';
import 'package:story_app/common/loading_state.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/responses/detail_story_response.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  DetailProvider(
      {required this.apiService, required this.authRepository, String? id}) {
    _fetchDetailStory(id!);
  }

  late DetailResponse _detailResponse;
  DetailResponse get detailResponse => _detailResponse;

  LoadingState detailState = const LoadingState.initial();

  Future<dynamic> _fetchDetailStory(String id) async {
    try {
      detailState = const LoadingState.loading();
      notifyListeners();

      final repository = await authRepository.getUser();
      final token = repository?.token;
      debugPrint('Token: $token');

      if (token != null) {
        final detailStory = await apiService.detailStory(token: token, id: id);
        if (detailStory.error) {
          detailState = LoadingState.error('Error: ${detailStory.message}');
        } else {
          detailState = const LoadingState.loaded();
          _detailResponse = detailStory;
        }
      } else {
        detailState = const LoadingState.error('No data returned from API');
      }
    } catch (e) {
      detailState = LoadingState.error('Error: $e');
      debugPrint(e.toString());
    }
    notifyListeners();
  }
}
