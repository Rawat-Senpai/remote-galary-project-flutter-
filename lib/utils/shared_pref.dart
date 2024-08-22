// lib/shared_prefs_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  // Create a private constructor
  SharedPrefsService._privateConstructor();

  // A static instance of the class
  static final SharedPrefsService _instance =
      SharedPrefsService._privateConstructor();

  // A getter to access the instance of the class
  static SharedPrefsService get instance => _instance;

  SharedPreferences? _prefs;

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get a value from SharedPreferences
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save a value to SharedPreferences
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Get an integer value
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Save an integer value
  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Get a boolean value
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Remove a value
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all values
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
