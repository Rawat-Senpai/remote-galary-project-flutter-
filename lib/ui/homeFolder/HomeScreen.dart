import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_storage_application/utils/app_constants.dart';
import 'package:photo_storage_application/utils/image_picker_service.dart';
import 'package:photo_storage_application/utils/shared_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;

  void _setImage(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    try {
      // Creating a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instanceFor(
        bucket: 'fluttergalaryproject.appspot.com/files',
      ).ref().child('images/${DateTime.now().toString()}.jpg');

      // Uploading the image to Firebase Storage
      final uploadTask = storageRef.putFile(_selectedImage!);

      // Get the download URL after upload
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      print('Image uploaded! Download URL: $downloadUrl');
    } catch (e) {
      // checking which repo is my code is pushing

      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding to the Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  ImagePickerService.pickImageFromCamera(_setImage),
              child: Text("Take Image from Camera"),
            ),
            ElevatedButton(
              onPressed: () =>
                  ImagePickerService.pickImageFromGallery(_setImage),
              child: Text("Take Image from Gallery"),
            ),
            SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 150)
                : Text("No Image Selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text("Upload Image to Firebase"),
            ),
          ],
        ),
      ),
    );
  }
}
