// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:vom_app/screens/articulos.dart';
// //import 'package:uni_links/uni_links.dart';
// import 'package:vom_app/screens/inicio.dart';
// //import 'package:vom_app/screens/detalle_noticia.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _handleAppStartup();
//   }

//   Future<void> _handleAppStartup() async {
//     await Future.delayed(const Duration(milliseconds: 500)); // Simula carga

//     String? slug;

//     // 🔔 Caso 1: Notificación push abrió la app
//     RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage?.data['slug'] != null) {
//       slug = initialMessage!.data['slug'];
//     }

//     // 🔗 Caso 2: La app fue abierta con un enlace externo
//     final initialLink = await getInitialLink();
//     if (initialLink != null) {
//       final uri = Uri.parse(initialLink);
//       if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'noticia') {
//         slug = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
//       }
//     }

//     if (slug != null && slug.isNotEmpty) {
//       _navigateToArticle(slug);
//     } else {
//       _navigateToHome();
//     }
//   }

//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const Inicio(title: "VOM Noticias")),
//     );
//   }

//   void _navigateToArticle(String slug) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => ArticlePage(slug: slug)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
