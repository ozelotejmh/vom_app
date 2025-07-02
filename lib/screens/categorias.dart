import 'package:flutter/material.dart';
import 'package:vom_app/screens/secciones.dart';

class Categorias extends StatelessWidget {
  Categorias({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'MORELOS',
      'image': 'assets/IMAGENES_CAT_VOM_MORELOS.png',
      'id': 18,
    },
    {
      'title': 'NACIONALES',
      'image': 'assets/IMAGENES_CAT_VOM_NACIONALES.png',
      'id': 15
    },
    {
      'title': 'INTERNACIONALES',
      'image': 'assets/IMAGENES_CAT_VOM_INTERNACIONALES.png',
      'id': 14
    },
    {
      'title': 'DEPORTES',
      'image': 'assets/IMAGENES_CAT_VOM_DEPORTES.png',
      'id': 16
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Tarjetas más altas
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryArticles(
                      categoryTitle: categories[index]['title']!,
                      categoryId: categories[index]['id']!,
                    ),
                  ),
                );
              },
              child: CategoryCard(
                title: categories[index]['title']!,
                image: categories[index]['image']!,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize:
                      (Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14) -
                          1,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
