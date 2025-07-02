import 'package:flutter/material.dart';
import 'package:vom_app/config/settings/change_notifier.dart';

// Decoradores Oscuros
const Color vomColorRojo = Color.fromARGB(255, 79, 8, 8);
const Color vomColorAzul = Color.fromARGB(255, 28, 37, 47);
//    ROJO MAS OSCURO PARA FONDORS INTERACTUABLES
const Color vomColorFondosRojo = Color.fromARGB(255, 62, 19, 36);
const Color vomColorMenuOscuro = Color.fromARGB(255, 44, 44, 44);

// DECORADORES CLAROS
const Color vomColorAzulClaro = Color.fromARGB(255, 45, 61, 76);
const Color vomColorRojoClaro = Color.fromARGB(255, 101, 28, 35);

//    ROJO MAS CLARO PARA FONDORS INTERACTUABLES
const Color vomColorRojoTenue = Color.fromARGB(255, 167, 132, 132);
const Color vomColorMenuClaro = Color.fromARGB(255, 176, 176, 176);
const Color vomColorSignosClaro = Color.fromARGB(255, 97, 97, 97);

final settings = SettingsNotifier().settings;

AppBarTheme vomAppbarTheme(Color colorfondo, Color colorTitulo) {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: colorfondo,
    foregroundColor: colorTitulo,
    scrolledUnderElevation: 0,
    titleTextStyle: const TextStyle(
      fontSize: 31.6,
      fontFamily: 'Helvetica', // Agregar la fuente Helvetica
    ),
    toolbarHeight: 150.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
    ),
    iconTheme: const IconThemeData(
      size: 40,
      color: Colors.white,
    ),
  );
}

BottomAppBarTheme vomBottomAppbar(Color colorfondo) {
  BottomAppBarTheme vomBottomAppbar = BottomAppBarTheme(
    color: colorfondo,
    elevation: 0,
  );
  return vomBottomAppbar;
}

TextTheme vomTextTheme(Color colortextotitulo, Color colortextobase) {
  TextTheme vomTextTheme = TextTheme(
      // Título grande
      displayLarge: TextStyle(
        fontSize: 31.0,
        fontWeight: FontWeight.bold,
        color: colortextobase,
        fontFamily: 'Helvetica',
      ),
      // Subtítulo con color
      titleMedium: TextStyle(
        fontSize: 20.5,
        fontWeight: FontWeight.bold,
        color: colortextotitulo,
        fontFamily: 'Helvetica',
      ),
      // Subtítulo sin color
      titleSmall: TextStyle(
        fontSize: 20.5,
        fontWeight: FontWeight.bold,
        color: colortextobase,
        fontFamily: 'Helvetica',
      ),
      // Texto simple en negritas
      bodyLarge: TextStyle(
        fontSize: settings.fontSize,
        color: colortextobase,
        fontWeight: FontWeight.bold,
        fontFamily: 'Helvetica',
      ),
      // Texto simple
      bodyMedium: TextStyle(
        fontSize: settings.fontSize,
        color: colortextobase,
        fontFamily: 'Helvetica',
      ),
      bodySmall: TextStyle(
        fontSize: settings.fontSize,
        color: Colors.white,
        fontFamily: 'Helvetica',
      ));
  return vomTextTheme;
}
