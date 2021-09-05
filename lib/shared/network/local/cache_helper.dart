import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic removedata({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  static Object getData({
    required String key,
  }) async {
    return sharedPreferences!.get(key);
  }

  static dynamic getBolean({
    required String key,
  }) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getBool(key);
  }

  // static String getString({
  //   required String key,
  // }) async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences!.getString(key);
  // }

  static Future<bool> savedata({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int)
      return await sharedPreferences!.setInt(key, value);
    else
      return await sharedPreferences!.setBool(key, value);
  }
}
