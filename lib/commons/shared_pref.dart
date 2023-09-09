import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static final PreferenceUtils _singleton = PreferenceUtils._internal();

  factory PreferenceUtils() {
    return _singleton;
  }

  PreferenceUtils._internal();

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? '');
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(key)!);
  }

  saveBool(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  hasKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
