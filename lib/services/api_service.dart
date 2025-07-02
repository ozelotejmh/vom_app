import 'dart:convert';
//import 'dart:ffi';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final String apiUrlBase =
      'https://vomnoticias.com/administrator/emml/services/index.php?key=intelinsidecore';

  Future<dynamic> fetchData(int tipoConsulta,
      {int? id, int? categoryId}) async {
    final articlesBox = Hive.box('articlesBox');

    // Verificar la conectividad
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      try {
        if (tipoConsulta == 0) {
          // CACHE DE CONSULTA TIPO 0
          final cachedData = articlesBox.get('articles');
          if (cachedData != null && cachedData is List) {
            return cachedData
                .map<List<Map<String, dynamic>>>((sublist) => (sublist as List)
                    .map<Map<String, dynamic>>(
                        (item) => Map<String, dynamic>.from(item as Map))
                    .toList())
                .toList();
          } else {
            throw Exception('Formato de caché inesperado para Consulta 0');
          }
        } else if (tipoConsulta == 1) {
          // CACHE DE CONSULTA TIPO 1
          if (articlesBox.containsKey(id.toString())) {
            final cachedData = articlesBox.get(id.toString());
            return cachedData
                .map<List<Map<String, dynamic>>>((sublist) => (sublist as List)
                    .map<Map<String, dynamic>>(
                        (item) => Map<String, dynamic>.from(item as Map))
                    .toList())
                .toList();
          } else {
            return null;
          }
        } else if (tipoConsulta == 2) {
          //  CACHE DE CONSULTA TIPO 2
          if (articlesBox.containsKey('articlesCateg$id')) {
            final cachedData = articlesBox.get('articlesCateg$id');
            return cachedData
                .map<Map<String, dynamic>>(
                    (e) => Map<String, dynamic>.from(e as Map))
                .toList();
          } else {
            return null;
          }
        }
      } catch (e) {
        throw Exception('Error al reconstruir la estructura desde caché: $e');
      }
    }

    // Construir la URL de la API
    String apiUrl = '$apiUrlBase&tipo=$tipoConsulta';
    if (tipoConsulta == 1 && id != null) {
      apiUrl += '&articleId=$id';
    } else if (tipoConsulta == 2 && id != null) {
      apiUrl += '&categoryId=$id';
    }

    // Realizar la solicitud HTTP
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = response.body;

      if (body.isEmpty) {
        throw Exception('La respuesta está vacía');
      }

      // if (body.startsWith('<') && body.endsWith('>')) {
      //   throw Exception('La respuesta parece ser HTML y no JSON');
      // }

      try {
        // Intentar decodificar el cuerpo de la respuesta
        final decodedData = jsonDecode(body);
        if (decodedData is List) {
          // Respuesta es una lista JSON
          if (tipoConsulta == 2) {
            // Consulta tipo 2
            final flattenedData = _flattenConsulta2(decodedData);
            articlesBox.put('articlesCateg$id', flattenedData);
            return flattenedData;
          } else if (tipoConsulta == 1) {
            // Consulta tipo 1
            List<String>? indices = articlesBox.get('index');

            if (indices != null) {
              if (articlesBox.containsKey(id.toString())) {
                indices.remove(id.toString());
              }
              indices.insert(0, id.toString());
              if (indices.length > 50) {
                final idsParaEliminar = indices.sublist(50);
                for (var oldid in idsParaEliminar) {
                  articlesBox.delete(oldid);
                }
              }
              articlesBox.put('index', indices);
            } else {
              List<String> indices = [id.toString()];
              articlesBox.put('index', indices);
            }
            articlesBox.put(id.toString(), decodedData);
            return decodedData;
          } else {
            // Consulta tipo 0
            articlesBox.put('articles', decodedData);
            return decodedData;
          }
        } else {
          throw Exception('Formato de respuesta no reconocido');
        }
      } catch (e) {
        throw Exception('Error en API al decodificar JSON: $e');
      }
    } else {
      throw Exception('Error en API en la solicitud: ${response.statusCode}');
    }
  }

  // Método que aplana los datos para tipo consulta 2
  List<Map<String, dynamic>> _flattenConsulta2(List<dynamic> data) {
    List<Map<String, dynamic>> flattenedData = [];

    for (var item in data) {
      if (item is List) {
        // Si el item es una lista, aplanarla
        flattenedData.addAll(item.cast<Map<String, dynamic>>());
      } else if (item is Map) {
        // Si el item es un mapa, asegurarnos de que es Map<String, dynamic>
        flattenedData.add(item as Map<String, dynamic>);
      }
    }
    return flattenedData;
  }
}
