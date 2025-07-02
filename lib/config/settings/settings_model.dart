// Modelo de configuraciones

class SettingsModel {
  bool isDarkMode;
  bool notificationsEnabled;
  double fontSize;

  SettingsModel({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.fontSize,
  });

  // Convertir el modelo a un mapa para persistencia
  Map<String, dynamic> toMap() {
    return {
      'isDarkMode': isDarkMode,
      'notificationsEnabled': notificationsEnabled,
      'fontSize': fontSize,
    };
  }

  // Crear un modelo desde un mapa
  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      isDarkMode: map['isDarkMode'] ?? true,
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      fontSize: (map['fontSize'] ?? 18.5).toDouble(),
    );
  }

  // Método copyWith
  SettingsModel copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    double? fontSize,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
