import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_storage_application/utils/app_constants.dart';
import 'package:photo_storage_application/utils/shared_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding to the Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),

            const SizedBox(height: 20), // Add space before the GestureDetector
            GestureDetector(
              onTap: () {
                SharedPrefsService.instance
                    .saveString(AppConstants.userId, "value saved ");
              },
              child: const Text(
                "Home Screen layout",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
