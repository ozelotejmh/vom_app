import 'package:shared_preferences/shared_preferences.dart';
import 'settings_model.dart';

// CARGAR Y GUARDAR LAS CONFIGURACIONES

class SettingsService {
  Future<SettingsModel> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsModel(
      isDarkMode: prefs.getBool('isDarkMode') ?? true,
      notificationsEnabled: prefs.getBool('notificationsEnabled') ?? true,
      fontSize: prefs.getDouble('fontSize') ?? 18.5,
    );
  }

  Future<void> saveSettings(SettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', settings.isDarkMode);
    await prefs.setBool('notificationsEnabled', settings.notificationsEnabled);
    await prefs.setDouble('fontSize', settings.fontSize);
  }
}
