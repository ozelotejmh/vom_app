import 'package:flutter/material.dart';
import 'settings_model.dart';
import 'settings_service.dart';

// Controlador de las configuraciones

class SettingsNotifier extends ChangeNotifier {
  SettingsModel _settings = SettingsModel(
    isDarkMode: true,
    notificationsEnabled: true,
    fontSize: 18.5,
  );

  final SettingsService _settingsService = SettingsService();

  SettingsModel get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await _settingsService.loadSettings();
    notifyListeners();
  }

  Future<void> updateDarkMode(bool isDarkMode) async {
    _settings = _settings.copyWith(isDarkMode: isDarkMode);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateNotifications(bool enabled) async {
    _settings = _settings.copyWith(notificationsEnabled: enabled);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateFontSize(double fontSize) async {
    _settings = _settings.copyWith(fontSize: fontSize);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }
}
