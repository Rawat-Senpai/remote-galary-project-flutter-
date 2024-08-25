import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> _pickImage(
      ImageSource source, Function(File?) onImagePicked) async {
    final pickedFile = await _picker.pickImage(source: source);
    onImagePicked(pickedFile != null ? File(pickedFile.path) : null);
  }

  static void showPicker(BuildContext context, Function(File?) onImagePicked) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery, onImagePicked);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, onImagePicked);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
