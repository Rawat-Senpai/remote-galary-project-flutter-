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
// controllers to retrieve the text from textFields

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    16.0), // Adding padding inside the Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligning text and fields to start
                  children: [
                    const Text(
                      "This application allows you to upload photos to the server so that you can use a remote server for a time being. You can view those photos after some time.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                        height:
                            20), // Add space between the text and TextFields
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border:
                            OutlineInputBorder(), // Adds a border to the TextField
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Add space between the TextFields
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border:
                            OutlineInputBorder(), // Adds a border to the TextField
                      ),
                      obscureText: true, // Hides the password text
                    ),
                    const SizedBox(height: 20), // Add space before the button
                    SizedBox(
                      width: double.infinity, // Full-width button
                      child: ElevatedButton(
                        onPressed: () {
                          print("button is clicked ");
                          // Retrieve text from TextFields
                          String email = emailController.text;
                          String password = passwordController.text;

                          // Show toast with email and password
                          Fluttertoast.showToast(
                            msg: "Email: $email\nPassword: $password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: const Text('Sync with Server'),
                      ),
                    ),
                  ],
                ),
              ),
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
