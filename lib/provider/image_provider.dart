import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagesProvider extends ChangeNotifier {
  String? imagePath;
  XFile? imageFile;
  String? description;

  void setImagePath(String? path) {
    imagePath = path;
    notifyListeners();
  }

  void setImageFile(XFile? file) {
    imageFile = file;
    notifyListeners();
  }
}
