import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';

  static Prefs? _preference = null;

  static Prefs get shared => _preference!;
  static SharedPreferences? _pref;

  Future<SharedPreferences?> instance() async {
    if (_pref != null) return _pref;
    await SharedPreferences.getInstance().then((value) {
      _pref = value;
    }).catchError((onErr) {
      _pref = null;
    });

    return _pref;
  }

  String? getString(String key) {
    return _pref?.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _pref!.setString(key, value);
  }

  int? getInt(String key) {
    return _pref?.getInt(key);
  }

  Future<bool> setInt(String key, int value) {
    return _pref!.setInt(key, value);
  }

  bool? getBool(String key) {
    return _pref?.getBool(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _pref!.setBool(key, value);
  }

  double? getDouble(String key) {
    return _pref?.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) {
    return _pref!.setDouble(key, value);
  }

  Future<void> removeKey(String key) {
    return _pref!.remove(key);
  }

  Future<void> clearPrefs() async {
    await _pref!.clear();
    await _pref!.reload();
    await SharedPreferences.getInstance().then((value) {
      _pref = value;
    }).catchError((onErr) {
      _pref = null;
    });
  }
}
