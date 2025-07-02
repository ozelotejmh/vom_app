import 'package:flutter/material.dart';
import 'package:vom_app/services/api_service.dart';
import 'package:vom_app/widgets/articulo_preview.dart';
import 'package:vom_app/widgets/navigation/appbars.dart';

class CategoryArticles extends StatelessWidget {
  final String categoryTitle;
  final int categoryId;

  const CategoryArticles({
    Key? key,
    required this.categoryTitle,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: VomAppbar(title: categoryTitle),
      body: FutureBuilder<dynamic>(
        future: apiService.fetchData(2, id: categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          final List<Map<String, dynamic>> articles =
              (snapshot.data as List<dynamic>).cast<Map<String, dynamic>>();

          return ListView.builder(
            itemCount: articles.length + 1,
            itemBuilder: (context, index) {
              if (index == articles.length) {
                // Footer
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 29, 38, 47),
                    borderRadius: BorderRadius.only(
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

              // Artículos
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: VomListArticles(
                  index: index,
                  article: articles[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
