import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _darkModeKey = 'dark_mode';

  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static bool getDarkMode() {
    // استخدام Future غير مناسب هنا، لكن سنستخدم طريقة غير متزامنة بسيطة
    return false; // قيمة افتراضية مؤقتة
  }

  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_darkModeKey, isDark);
  }

  static Future<bool> loadDarkMode() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_darkModeKey) ?? false;
  }
}
