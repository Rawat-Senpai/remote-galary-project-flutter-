import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    "Register a new account to start using the application.",
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
                        String email = emailController.text;
                        String password = passwordController.text;

                        if (email.isNotEmpty && password.isNotEmpty) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            User? user = userCredential.user;
                            if (user != null) {
                              Fluttertoast.showToast(
                                msg:
                                    "Registration successful. UID: ${user.uid}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              Navigator.pop(context);
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
                      child: const Text('Register'),
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
