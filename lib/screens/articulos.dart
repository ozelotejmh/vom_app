import 'package:flutter/material.dart';
import 'package:vom_app/services/api_service.dart';
import 'package:vom_app/widgets/navigation/appbars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late Future<dynamic> _articleFuture;
  final ScrollController _scrollController = ScrollController();
  final double _initialImageHeight = 300.0;
  final double _minHeight = 100.0;
  double _imageHeight = 300.0;

  @override
  void initState() {
    super.initState();
    _articleFuture = ApiService().fetchData(1, id: int.parse(widget.id));

    _scrollController.addListener(() {
      setState(() {
        _imageHeight = (_initialImageHeight - _scrollController.offset)
            .clamp(_minHeight, _initialImageHeight);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () =>
              Navigator.of(context).pop(), // Cierra la imagen al tocar fuera
          child: Container(
            color: Theme.of(context).canvasColor.withAlpha((0.8 * 255).toInt()),
            child: Center(
              child: Hero(
                tag: 'fullImage',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildArticleText(String fullText, String imageUrl) {
    final parts = fullText.split('{{IMAGE}}');
    List<Widget> widgets = [];

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].trim().isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              parts[i],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.justify,
            ),
          ),
        );
      }
      if (i < parts.length - 1) {
        widgets.add(
          GestureDetector(
            onTap: () => _showFullImage(
              context,
              'https://vomnoticias.com/$imageUrl',
            ),

            // Aqui mov

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Hero(
                  tag: 'bodyImage$i',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      imageUrl: 'https://vomnoticias.com/$imageUrl',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ),
        );
      }
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VomAppbar(title: widget.title),
      body: FutureBuilder<dynamic>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          final dynamic article = snapshot.data;

          if (article is List) {
            return _buildArticleFromList(article);
          } else {
            return const Center(child: Text('Formato de datos desconocido'));
          }
        },
      ),
    );
  }

  Widget _buildArticleFromList(List<dynamic> articleList) {
    final article = articleList[0][0];
    final imageUrl =
        'https://vomnoticias.com/${jsonDecode(article['images'])['image_intro']}';

    // Obtener el valor de la imagen en el cuerpo del texto
    final imagePosition = article['notes_image_body'] ?? '';

    return SafeArea(
      child: Stack(
        children: [
          // Contenido desplazable
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: _initialImageHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Título
                    Text(
                      article['title'] ?? 'Sin título',
                      style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    // Texto introductorio
                    Text(
                      article['introtext'] ?? 'Sin descripción',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    // Texto completo del artículo con imágenes
                    _buildArticleText(
                        article['fulltext'] ?? 'Sin contenido', imagePosition),
                  ],
                ),
              ),
            ),
          ),
          // Imagen fija en la parte superior que se reduce
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showFullImage(context, imageUrl),
              child: AnimatedContainer(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                duration: const Duration(milliseconds: 100),
                height: _imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: 'fullImage',
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
