import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static final SharedPreferenceManager _instance =
      SharedPreferenceManager._internal();
  SharedPreferences? _prefs;

  factory SharedPreferenceManager() {
    return _instance;
  }

  SharedPreferenceManager._internal() {
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _init();
    _prefs?.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _init();
    _prefs?.setBool(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> remove(String key) async {
    await _init();
    _prefs?.remove(key);
  }

  Future<void> clear() async {
    await _init();
    _prefs?.clear();
  }
}
