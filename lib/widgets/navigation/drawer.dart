import 'package:flutter/material.dart';
import 'package:vom_app/screens/config/config.dart';
import 'package:vom_app/screens/legal/about_vom_screen.dart';
import 'package:vom_app/screens/legal/privacy_policy_screen.dart';
import 'package:vom_app/screens/legal/terms_of_use_screen.dart';

class VomDrawer extends StatelessWidget {
  final int selectedIndex; // Índice seleccionado
  final Function(int) onItemTapped; // Función para manejar el cambio

  const VomDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          Theme.of(context).dialogBackgroundColor, // Color oscuro para el menú
      child: ListView(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 28, 37, 47),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Menú',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
              ],
            ),
          ),
          // Botón de Inicio
          VomTile(
            icon: Icons.home,
            title: "Inicio",
            size: 40,
            isSelected: selectedIndex == 0,
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              onItemTapped(0); // Cambia a pantalla de Inicio
            },
          ),
          // Botón de Municipios
          VomTile(
            icon: const IconData(0xf009,
                fontFamily: 'FontAwesome5', fontPackage: null),
            title: "Municipios",
            isSelected: selectedIndex == 1,
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              onItemTapped(1); // Cambia a pantalla de Municipios
            },
          ),
          const Divider(color: Colors.white70),
          // Otras opciones que no cambian de pantalla principal
          VomTile(
            icon: Icons.settings,
            title: 'Configuración',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          const Divider(color: Colors.white70),
          VomTile(
            icon: Icons.info,
            title: 'Sobre Nosotros',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutVomScreen()));
            },
          ),
          VomTile(
            icon: Icons.article,
            title: 'Condiciones de uso',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TerminosUsoScreen(),
                ),
              );
            },
          ),
          VomTile(
            icon: Icons.privacy_tip,
            title: 'Política de Privacidad',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PoliticaPrivacidadScreen(),
                ),
              );
            },
          ),
          const Divider(color: Colors.white70),
          // Leyenda "Created by Emml Mrls"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Created by Emml Mrls', // Cambia a tu alias o cualquier texto que prefieras
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VomTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected; // Indica si el ítem está seleccionado
  final VoidCallback? onTap;
  final double? size;

  const VomTile({
    Key? key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.onTap,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 40, // Ancho fijo para alinear todos los íconos
        child: Center(
          child: Icon(
            icon,
            size: size ?? 24, // Tamaño predeterminado si no se especifica
            color:
                isSelected ? Theme.of(context).primaryColorDark : Colors.white,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColorDark : Colors.white,
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
