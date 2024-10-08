import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_storage_application/ui/bottomNavigationBar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_storage_application/ui/registerFolder/registerScreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  // Controllers to retrieve text from TextFields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Adding padding inside the Card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Aligning text and fields to start
                children: [
                  const Text(
                    "This application allows you to upload photos to the server so that you can use a remote server for a time being. You can view those photos after some time.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                      height: 20), // Add space between the text and TextFields
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
                      onPressed: () async {
                        print("Button is clicked");
                        // Retrieve text from TextFields
                        String email = emailController.text;
                        String password = passwordController.text;

                        if (email.isNotEmpty && password.isNotEmpty) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            User? user = userCredential.user;
                            if (user != null) {
                              Fluttertoast.showToast(
                                msg: "Login successful. UID: ${user.uid}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationBarExample(), // Replace with your target screen
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }

                          emailController.clear();
                          passwordController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Please fill in the email and password')),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Add space before the registration text
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RegistrationScreen(), // Replace with your registration screen
                          ),
                        );
                      },
                      child: const Text('Register a new account'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
