import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RateUsBottomSheet extends StatefulWidget {
  const RateUsBottomSheet({super.key});

  @override
  State<RateUsBottomSheet> createState() => _RateUsBottomSheetState();
}

class _RateUsBottomSheetState extends State<RateUsBottomSheet> {
  int rating = 0;
  final feedbackController = TextEditingController();
  bool submitted = false;

  Future<void> _handleRating(int stars) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => rating = stars);

    if (stars >= 4) {
      await prefs.setBool('alreadyRated', true);
      final inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      } else {
        const url = 'https://play.google.com/store/'; // <-- ajusta esto
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _submitFeedback(String comentario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alreadyRated', true);
    await prefs.setInt('appOpens', -40);
    enviarComentario(comentario);
    setState(() => submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding:
            MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
        child: Wrap(
          children: [
            const Center(
              child: Text('¿Qué te ha parecido la app?',
                  style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                final filled = i < rating;
                return IconButton(
                  icon: Icon(filled ? Icons.star : Icons.star_border,
                      color: Colors.amber),
                  onPressed: () => _handleRating(i + 1),
                );
              }),
            ),
            if (rating > 0 && rating < 4 && !submitted) ...[
              const SizedBox(height: 12),
              const Text('¿Cómo podemos mejorar?',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: feedbackController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Escribe tus comentarios...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  final comentario = feedbackController.text.trim();
                  _submitFeedback(comentario);
                },
                child: const Text('Enviar'),
              ),
            ],
            if (submitted)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('¡Gracias por tus comentarios! 🙌'),
              ),
            Center(
              child: TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('alreadyRated', true);
                  Navigator.pop(context);
                },
                child: const Text('No, gracias'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> enviarComentario(String comentario) async {
  const url =
      'https://vomnoticias.com/administrator/emml/services/rev/index.php';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'comentario': comentario}),
  );

  if (response.statusCode == 200) {
    print("Enviado correctamente");
  } else {
    print("Fallo al enviar");
  }
}
