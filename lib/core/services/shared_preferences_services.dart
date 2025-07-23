import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async {
    final SharedPreferences data = await prefs;
    data.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    final SharedPreferences data = await prefs;
    data.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences data = await prefs;
    return data.getString(key);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences data = await prefs;
    return data.getBool(key);
  }

  Future<void> remove(String key) async {
    final SharedPreferences data = await prefs;
    data.remove(key);
  }

  Future<void> clearAll() async {
    final SharedPreferences data = await prefs;
    data.clear();
  }
}
