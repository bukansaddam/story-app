import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/responses/upload_response.dart';

class UploadProvider extends ChangeNotifier {
  bool isUploading = false;
  String message = '';
  UploadResponse? uploadResponse;

  final ApiService apiService;
  final AuthRepository authRepository;

  UploadProvider({required this.apiService, required this.authRepository});

  Future<void> upload(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    try {
      message = '';
      uploadResponse = null;
      isUploading = true;
      notifyListeners();

      final repository = await authRepository.getUser();
      final token = repository?.token;
      debugPrint('Token: $token');

      uploadResponse =
          await apiService.uploadStory(bytes, fileName, description, token!);
      message = uploadResponse?.message ?? "success";
      debugPrint('UploadResponse: ${uploadResponse?.message}');
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
