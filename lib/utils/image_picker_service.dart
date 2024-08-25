import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> pickImageFromCamera(Function(File?) onImagePicked) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    onImagePicked(pickedFile != null ? File(pickedFile.path) : null);
  }

  static Future<void> pickImageFromGallery(
      Function(File?) onImagePicked) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    onImagePicked(pickedFile != null ? File(pickedFile.path) : null);
  }
}
