import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_storage_application/ui/homeFolder/HomeScreen.dart';
import 'package:photo_storage_application/ui/bottomNavigationBar.dart';
import 'package:photo_storage_application/ui/loginFolder/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to Home Screen after a delay
    Future.delayed(const Duration(seconds: 2), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarExample()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Loginscreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("first Text View ")],
      ),
    );
  }
}
