import 'dart:io';

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
  File? _image1;
  File? _image2;

  void _setImage(File? image, int boxNumber) {
    setState(() {
      if (boxNumber == 1) {
        _image1 = image;
      } else {
        _image2 = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding to the Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageBox(_image1, 1),
            SizedBox(height: 20),
            _buildImageBox(_image2, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(File? image, int boxNumber) {
    return GestureDetector(
      onTap: () => ImagePickerService.showPicker(context, (pickedImage) {
        _setImage(pickedImage, boxNumber);
      }),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          image: image != null
              ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
              : null,
        ),
        child: image == null ? Center(child: Text("Select Photo")) : null,
      ),
    );
  }
}
