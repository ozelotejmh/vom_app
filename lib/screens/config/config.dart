import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vom_app/config/settings/change_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _systemNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
  }

  Future<void> _checkNotificationStatus() async {
    final enabled = await areNotificationsEnabled();
    setState(() {
      _systemNotificationsEnabled = enabled;
    });
  }

  Future<void> _openSettings() async {
    await openNotificationSettings();
    _checkNotificationStatus(); // Verificar estado al regresar de las configuraciones
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = context.watch<SettingsNotifier>();
    final settings = settingsNotifier.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuraciones',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ajustes Generales',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // MODO OSCURO
            const SizedBox(height: 10),
            SwitchListTile(
              title: Text(
                'Modo Oscuro',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: settings.isDarkMode,
              onChanged: (value) {
                settingsNotifier.updateDarkMode(value);
              },
              secondary: Icon(
                settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
            const SizedBox(height: 20),
            // NOTIFICACIONES
            Text(
              'Notificaciones',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(
                _systemNotificationsEnabled
                    ? Icons.notifications
                    : Icons.notifications_off,
              ),
              title: Text(
                _systemNotificationsEnabled
                    ? 'Notificaciones activadas en el sistema'
                    : 'Notificaciones desactivadas en el sistema',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: ElevatedButton(
                onPressed: _openSettings,
                child: const Text('Configurar'),
              ),
            ),
            const SizedBox(height: 20),
            // TAMAÑO DEL TEXTO
            Text(
              'Tamaño del texto',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: settings.fontSize,
              min: 14.0,
              max: 32.0,
              divisions: 8,
              label: '${settings.fontSize.toStringAsFixed(1)} pt',
              onChanged: (value) {
                settingsNotifier.updateFontSize(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> areNotificationsEnabled() async {
  final status = await Permission.notification.status;
  return status.isGranted;
}

Future<void> openNotificationSettings() async {
  await openAppSettings();
}
