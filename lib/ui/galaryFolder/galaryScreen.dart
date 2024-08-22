import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_storage_application/utils/app_constants.dart';
import 'package:photo_storage_application/utils/shared_pref.dart';

class GalaryScreen extends StatelessWidget {
  const GalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              String output = SharedPrefsService.instance
                  .getString(AppConstants.userId)
                  .toString();
              print("-----");
              print(output);
            },
            child: const Text("Galary  Screen layout"),
          )
        ],
      ),
    );
  }
}
