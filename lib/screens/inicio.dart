import 'package:flutter/material.dart';
import 'package:vom_app/screens/categorias.dart';
import 'package:vom_app/screens/rateus.dart';
import 'package:vom_app/services/api_service.dart';
import 'package:vom_app/widgets/adds.dart';
import 'package:vom_app/widgets/articulo_preview%20copy.dart';
import 'package:vom_app/widgets/navigation/appbars.dart';
import 'package:vom_app/widgets/navigation/bottom_navigation.dart';
import 'package:vom_app/widgets/navigation/drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key, required this.title});
  final String title;

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _selectedIndex = 0; // Índice para controlar la pantalla seleccionada

  @override
  void initState() {
    super.initState();
    _setupFCM();
    //_checkAndShowRatingPrompt(); // Mostrar calificación si aplica
  }

  void _setupFCM() async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('todos');
      print("Suscrito al topic 'todos'");
    } catch (e) {
      print("Error al suscribirse a FCM: $e");
    }
  }

  // Mostrar widget de calificación solo si se cumplen condiciones
  void _checkAndShowRatingPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    final opens = prefs.getInt('appOpens') ?? 0;
    final alreadyRated = prefs.getBool('alreadyRated') ?? false;

    prefs.setInt('appOpens', opens + 1); // registrar nueva apertura
    if (opens >= 4 && !alreadyRated) {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await Future.delayed(const Duration(seconds: 4));
        if (mounted) {
          showModalBottomSheet<Widget>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) => const RateUsBottomSheet(),
          );
        }
      }
    }
  }

  // Lista de pantallas
  final List<Widget> _screens = [
    const VomArticulos(),
    Categorias(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VomAppbar(title: "NOTICIAS"),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens, // Las pantallas que pueden mostrarse
      ),
      bottomNavigationBar: VomBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      drawer: VomDrawer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// MOSTRADOR DE NOTAS
class VomArticulos extends StatelessWidget {
  const VomArticulos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return SafeArea(
      child: FutureBuilder<dynamic>(
        future: apiService.fetchData(0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 60),
                  const SizedBox(height: 10),
                  const Text('No hay conexión o datos disponibles'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => (() {}), // Fuerza recarga
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final dynamic data = snapshot.data;

          List<dynamic> allArticles = [];
          if (data is Map<String, dynamic>) {
            final List municipios = data['municipios'] ?? [];
            final List morelos = data['morelos'] ?? [];
            final List nacionales = data['nacionales'] ?? [];
            final List internacionales = data['internacionales'] ?? [];
            final List deportes = data['deportes'] ?? [];

            allArticles = [
              ...municipios,
              ...morelos,
              ...nacionales,
              ...internacionales,
              ...deportes,
            ];
          } else if (data is List) {
            allArticles = data.expand((category) => category).toList();
          }

          return ListView.builder(
            itemCount: allArticles.length +
                (allArticles.length ~/ 2) +
                1, // suma widgets intercalados + footer
            itemBuilder: (context, index) {
              // Footer al final de la lista
              if (index == allArticles.length + (allArticles.length ~/ 2)) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.4),
                      topRight: Radius.circular(24.4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                    child: Center(
                      child: Image.asset('assets/radio.png',
                          height: 200, fit: BoxFit.contain),
                    ),
                  ),
                );
              }

              // Cada tercer índice (después de 2 artículos), muestra el WebAddImagen
              final isAdPosition = (index + 1) % 3 == 0;
              if (isAdPosition) {
                return const WebAddImagen(); // tu widget adicional
              }

              // Calcular el índice real de artículos, ignorando los widgets intercalados
              final realIndex = index - (index ~/ 3);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: VomListArticleswCateg(
                  index: realIndex,
                  article: allArticles[realIndex],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
