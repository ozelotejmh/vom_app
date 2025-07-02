import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vom_app/config/settings/change_notifier.dart';
import 'package:vom_app/config/themes/vom_theme.dart';
import 'package:vom_app/screens/inicio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('articlesBox');
  final settingsNotifier = SettingsNotifier();
  await settingsNotifier.loadSettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => settingsNotifier,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsNotifier>().settings;
    return MaterialApp(
      title: 'VOM APP',
      debugShowCheckedModeBanner: false,
      theme: VomTheme().theme(settings.isDarkMode, settings.fontSize),
      home: const Inicio(title: "VOM Noticias"),
    );
  }
}
