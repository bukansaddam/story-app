import 'package:flutter/material.dart';
import 'package:story_app/common/result_state.dart';
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

  late ResultState _state;
  ResultState get state => _state;

  String? _message;
  String? get message => _message;

  Future<dynamic> _fetchDetailStory(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final repository = await authRepository.getUser();
      final token = repository?.token;
      debugPrint('Token: $token');

      if (token != null) {
        final detailStory = await apiService.detailStory(token: token, id: id);
        if (detailStory.error) {
          _state = ResultState.noData;
        } else {
          _state = ResultState.hasData;
          _detailResponse = detailStory;
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
