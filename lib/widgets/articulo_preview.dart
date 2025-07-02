import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:vom_app/screens/articulos.dart';

class VomListArticles extends StatelessWidget {
  final int index;
  final Map<String, dynamic> article;

  const VomListArticles({Key? key, required this.index, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? images;
    if (article['images'] != null && article['images'].isNotEmpty) {
      images = jsonDecode(article['images']);
    }
    String? imageIntro = images?['image_intro'];
    String? notesImage = (article['notes_image']);
    if (notesImage != null && !notesImage.startsWith('http')) {
      notesImage = 'https://vomnoticias.com/$notesImage';
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(
                  title: article["category_title"],
                  id: article['id'].toString(),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.5, vertical: 3),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 6),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          // IMAGEN DE CREADOR
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: SizedBox(
                              width: 76,
                              height: 76,
                              child: notesImage != null
                                  ? CachedNetworkImage(
                                      imageUrl: notesImage,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/palomita_blanca.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          // NOMBRE DE CREADOR
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.5, 0, 0, 0),
                            child: Text(
                              article['creator_name'] ?? 'Sin Creador',
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (imageIntro != null && imageIntro.isNotEmpty)
                    // IMAGEN DE NOTA
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 11),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: CachedNetworkImage(
                          imageUrl: 'https://vomnoticias.com/$imageIntro',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  // TITULO DE NOTA
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: Text(
                      article['title'] ?? 'Sin título',
                      style: const TextStyle(
                        fontSize: 27,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ),
                  // TITULO DE INTRODUCCION
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      article['introtext'] ?? 'Sin descripción',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
