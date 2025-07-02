import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vom_app/config/settings/change_notifier.dart';
import 'package:vom_app/main.dart';

void main() {
  testWidgets('Inicio screen loads correctly', (WidgetTester tester) async {
    // Configuramos el SettingsNotifier con valores predeterminados
    final settingsNotifier = SettingsNotifier();

    // Cargamos la aplicación dentro de un ChangeNotifierProvider
    await tester.pumpWidget(
      ChangeNotifierProvider<SettingsNotifier>(
        create: (_) => settingsNotifier,
        child: const MyApp(),
      ),
    );

    // Verifica que el AppBar tiene el título esperado
    expect(find.text('NOTICIAS'), findsOneWidget);

    // Verifica que el Drawer se encuentra presente
    expect(find.byType(Drawer), findsOneWidget);

    // Verifica que se carga al menos un elemento en la lista (si hay datos)
    expect(find.byType(ListView), findsOneWidget);

    // Si tienes un footer o un indicador de carga, puedes verificarlo
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
