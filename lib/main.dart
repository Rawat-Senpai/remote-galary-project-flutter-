import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_storage_application/ui/splashScreen.dart';
import 'package:photo_storage_application/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyDIbd-P3sRKDxMt1aqIGDUIPFg7KwPhXUQ',
            appId: "1:856900350869:android:42083e922601b65ad77c9c",
            messagingSenderId: "856900350869",
            projectId: "fluttergalaryproject"));
    print("Firebase initialization complete");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
