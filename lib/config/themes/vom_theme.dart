import 'package:flutter/material.dart';
import 'package:vom_app/config/constants.dart';

class VomTheme {
  ThemeData theme(bool isDarkMode, double fontSize) {
    // Generador de TextTheme con tamaño dinámico
    TextTheme vomTextTheme(Color colortextotitulo, Color colortextobase) {
      return TextTheme(
        displayLarge: TextStyle(
          fontSize: fontSize + 8,
          fontWeight: FontWeight.bold,
          color: colortextobase,
          fontFamily: 'Helvetica',
        ),
        titleMedium: TextStyle(
          fontSize: fontSize + 2,
          fontWeight: FontWeight.bold,
          color: colortextotitulo,
          fontFamily: 'Helvetica',
        ),
        bodyMedium: TextStyle(
          fontSize: fontSize,
          color: colortextobase,
          fontFamily: 'Helvetica',
        ),
        // Otros estilos pueden ajustarse similarmente
      );
    }

    if (isDarkMode) {
      // TEMA OSCURO
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        // COLOR PRIMARIO QUE SE USA PARA ELEMENTOS PRINCIPALES (BOTONES, ACCENTOS, ETC.)
        primaryColor: vomColorAzul,

        // VARIANTE MÁS OSCURA DEL COLOR PRIMARIO, USADA PARA SOMBRAS O ELEMENTOS MÁS DESTACADOS
        primaryColorDark: vomColorRojo,

        // COLOR DEL FONDO GENERAL (USADO DETRÁS DE LA MAYORÍA DE LOS WIDGETS)
        canvasColor: Colors.black,

        // COLOR DE LAS TARJETAS (CARD WIDGETS) Y CONTENEDORES DESTACADOS
        cardColor: vomColorFondosRojo,

        // COLOR QUE SE USA CUANDO UN ELEMENTO RECIBE FOCO (EJEMPLO: TEXTFIELDS O BOTONES ENFOCADOS)
        focusColor: vomColorRojo,

        // COLOR DESTACADO CUANDO UN ELEMENTO SE RESALTA O SE ANIMA
        highlightColor: Colors.white,

        // COLOR DE SUGERENCIAS O ELEMENTOS SECUNDARIOS COMO TEXTO DE AYUDA
        hintColor: vomColorRojoTenue,

        // COLOR DEL FONDO PARA DIÁLOGOS (ALERTAS, POPUPS, ETC.)
        dialogBackgroundColor: vomColorMenuOscuro,

        // COLOR PARA ELEMENTOS DESHABILITADOS (BOTONES, ICONOS, TEXTO INACTIVO)
        disabledColor: Colors.grey,

        // COLOR DE LAS LÍNEAS DIVISORAS ENTRE ELEMENTOS (DIVIDERS)
        dividerColor: Colors.white,

        appBarTheme: vomAppbarTheme(vomColorAzul, Colors.white),
        bottomAppBarTheme: vomBottomAppbar(vomColorAzul),
        textTheme: vomTextTheme(vomColorRojoTenue, Colors.white),
      );
    } else {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: vomColorAzulClaro,
        primaryColorDark: vomColorSignosClaro,
        canvasColor: Colors.white,
        cardColor: vomColorMenuClaro,
        focusColor: vomColorRojoClaro,
        dialogBackgroundColor: vomColorMenuClaro,
        appBarTheme: vomAppbarTheme(vomColorAzulClaro, Colors.black),
        bottomAppBarTheme: vomBottomAppbar(vomColorAzulClaro),
        textTheme: vomTextTheme(vomColorFondosRojo, Colors.black),
      );
    }
  }
}
