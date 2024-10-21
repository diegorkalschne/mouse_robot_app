import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  SharedService._internal();

  factory SharedService() {
    return _instance;
  }

  static final SharedService _instance = SharedService._internal();
  static SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveString(String key, String value, {String suffix = ''}) async {
    final pref = await _getPrefs();
    await pref.setString(key + suffix, value);
  }

  Future<String?> getString(String key, {String suffix = ''}) async {
    final pref = await _getPrefs();
    return pref.getString(key + suffix);
  }

  Future<void> saveDouble(String key, double value, {String suffix = ''}) async {
    final pref = await _getPrefs();
    await pref.setDouble(key + suffix, value);
  }

  Future<double?> getDouble(String key, {String suffix = ''}) async {
    final pref = await _getPrefs();
    return pref.getDouble(key + suffix);
  }

  Future<bool> hasKey(String key, {String suffix = ''}) async {
    final pref = await _getPrefs();
    return pref.containsKey(key + suffix);
  }

  Future<void> remove(String key, {String suffix = ''}) async {
    final pref = await _getPrefs();
    await pref.remove(key + suffix);
  }
}
