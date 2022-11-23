import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late SharedPreferences _pref;

  static Future init() async => _pref = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await _pref.setString('token', token);
  static String getToken() => _pref.getString('token')!;

  static Future setUserFName(String name) async =>
      await _pref.setString('name', name);
  static String getUserFName() => _pref.getString('name')!;

  static Future setUserNationalId(int id) async =>
      await _pref.setInt('nationId', id);
  static int getUserNationalId() => _pref.getInt('nationId')!;

  static Future setUserId(int id) async => await _pref.setInt('id', id);
  static int getUserId() => _pref.getInt('id')!;

  static Future setUserRole(int role) async => await _pref.setInt('role', role);
  static int getUserRole() => _pref.getInt('role') ?? 1;

  static Future setIsAdmin(bool isAdmin) async =>
      await _pref.setBool('isAdmin', isAdmin);
  static bool getIsAdmin() => _pref.getBool('isAdmin') ?? false;

  static Future setNotified(bool noti) async =>
      await _pref.setBool('noti', noti);
  static bool getNotified() => _pref.getBool('noti') ?? true;

  static Future setNotifiedDelayed(bool noti) async =>
      await _pref.setBool('notiDelayed', noti);
  static bool getNotifiedDelayed() => _pref.getBool('notiDelayed') ?? true;

  static Future setNotifiedCancelled(bool noti) async =>
      await _pref.setBool('notiCancelled', noti);
  static bool getNotifiedCancelled() => _pref.getBool('notiCancelled') ?? true;

  static Future setNotifiedTransferred(bool noti) async =>
      await _pref.setBool('notiTransferred', noti);
  static bool getNotifiedTransferred() =>
      _pref.getBool('notiTransferred') ?? true;

  static Future setNotifiedDDay(bool noti) async =>
      await _pref.setBool('notiDDay', noti);
  static bool getNotifiedDDay() => _pref.getBool('notiDDay') ?? true;

  static Future setNotified1DayBefore(bool noti) async =>
      await _pref.setBool('noti1DayBefore', noti);
  static bool getNotified1DayBefore() =>
      _pref.getBool('noti1DayBefore') ?? true;

  static Future setNotified2DayBefore(bool noti) async =>
      await _pref.setBool('noti2DayBefore', noti);
  static bool getNotified2DayBefore() =>
      _pref.getBool('noti2DayBefore') ?? true;

  static Future setNotified3DayBefore(bool noti) async =>
      await _pref.setBool('noti3DayBefore', noti);
  static bool getNotified3DayBefore() =>
      _pref.getBool('noti3DayBefore') ?? true;

  static Future setNotified5DayBefore(bool noti) async =>
      await _pref.setBool('noti5DayBefore', noti);
  static bool getNotified5DayBefore() =>
      _pref.getBool('noti5DayBefore') ?? true;

  static Future setNotified7DayBefore(bool noti) async =>
      await _pref.setBool('noti7DayBefore', noti);
  static bool getNotified7DayBefore() =>
      _pref.getBool('noti7DayBefore') ?? true;
}
