import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();
  late final SharedPreferences _preferences;

  factory TLocalStorage() {
    return _instance;
  }

  TLocalStorage._internal();

  // Khởi tạo SharedPreferences
  static Future<void> init() async {
    _instance._preferences = await SharedPreferences.getInstance();
  }

  // --- Các phương thức lưu trữ dữ liệu ---

  Future<void> saveData<T>(String key, T value) async {
    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    } else {
      throw Exception('Unsupported type for SharedPreferences: ${T.runtimeType}');
    }
  }

  // --- Các phương thức đọc dữ liệu ---

  T? readData<T>(String key) {
    if (T == String) {
      return _preferences.getString(key) as T?;
    } else if (T == int) {
      return _preferences.getInt(key) as T?;
    } else if (T == bool) {
      return _preferences.getBool(key) as T?;
    } else if (T == double) {
      return _preferences.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _preferences.getStringList(key) as T?;
    }
    return null;
  }

  // --- Các phương thức xóa dữ liệu ---

  Future<bool> removeData(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clearAll() async {
    return await _preferences.clear();
  }
}