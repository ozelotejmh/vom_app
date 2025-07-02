import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vom_app/services/api_service.dart';
import 'dart:math';

class WebAddImagen extends StatefulWidget {
  const WebAddImagen({super.key, this.prev});
  final List? prev;

  @override
  State<WebAddImagen> createState() => _WebAddImagenState();
}

class _WebAddImagenState extends State<WebAddImagen> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return FutureBuilder<dynamic>(
        future: apiService.fetchData(3),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar la imagen'));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          final List data = snapshot.data;
          final String imageUrl =
              'https://vomnoticias.com/${jsonDecode(data[0][Random().nextInt(data[0].length)]['params'])['imageurl']}';
          return GestureDetector(
            onTap: () => [],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
