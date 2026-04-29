import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  String _language = 'vi';
  bool _notifications = true;

  bool get darkMode => _darkMode;
  String get language => _language;
  bool get notifications => _notifications;

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    _language = prefs.getString('language') ?? 'vi';
    _notifications = prefs.getBool('notifications') ?? true;
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _darkMode = !_darkMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
    notifyListeners();
  }

  Future<void> changeLanguage(String lang) async {
    _language = lang;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _notifications = !_notifications;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', _notifications);
    notifyListeners();
  }
}
