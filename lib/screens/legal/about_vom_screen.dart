import 'package:flutter/material.dart';
import 'package:vom_app/widgets/navigation/appbars.dart';

class AboutVomScreen extends StatelessWidget {
  const AboutVomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VomAppbar(title: "Noticias"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Sobre Nosotros',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
            const SizedBox(height: 16.0),
            Text(
              'VOM NOTICIAS, la fuente de información que está redefiniendo el periodismo en México.\n\nNos dirigimos a quienes desean estar al tanto de la actualidad diaria en Morelos y más allá. Con un enfoque en el periodismo digital y siempre a la vanguardia, ofrecemos información sobre política, deportes, cultura y temas sociales, tanto a nivel nacional como internacional.\n\n¡Conéctate con nosotros y mantente informado!',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
