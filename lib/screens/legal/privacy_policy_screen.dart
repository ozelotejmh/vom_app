import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vom_app/widgets/navigation/appbars.dart';

class PoliticaPrivacidadScreen extends StatelessWidget {
  const PoliticaPrivacidadScreen({Key? key}) : super(key: key);

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
              child: Text('Política de Privacidad',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Última actualización: 5 de mayo de 2025',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'En “VOM Noticias Móvil” valoramos tu privacidad. Esta Política de Privacidad explica cómo recopilamos, usamos y protegemos la información cuando usas nuestra aplicación móvil.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Alcance y Definiciones',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              '• Aplicación: se refiere a “VOM Móvil”, desarrollada y publicada por VOM Noticias.\n• Usuario: eres tú, la persona que accede y utiliza la aplicación.\n• Datos personales: cualquier información que puede identificarte directa o indirectamente, como nombre, correo electrónico o datos de uso del dispositivo.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '1. Información Recopilada',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Actualmente, no solicitamos datos personales sensibles para el uso de la app. Sin embargo, podríamos recopilar algunos datos básicos de forma automática, como:\n• Información técnica del dispositivo (tipo, sistema operativo, versión del navegador).\n• Dirección IP y datos de conexión para fines de seguridad y análisis de uso.\n• Datos anónimos sobre cómo navegas dentro de la app (por ejemplo, qué secciones visitas más). \nEn el futuro, si decidimos ofrecer funciones personalizadas como encuestas o preferencias, te pediremos permiso explícito antes de recopilar información adicional. ',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '2. Uso de la Información',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'La información recopilada se utiliza únicamente para:\n• Mejorar el funcionamiento y rendimiento de la app.\n• Analizar qué contenido es más consultado, de manera anónima.\n• Garantizar la seguridad técnica del servicio.\nNo utilizamos tus datos para fines comerciales, ni los compartimos con terceros para publicidad personalizada.',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '3. Servicios de Terceros',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Nuestra app puede usar herramientas de terceros, como Firebase o Google Analytics, que pueden recopilar datos de uso anónimos para ayudarnos a entender el rendimiento y funcionamiento de la app. Estos proveedores están sujetos a sus propias políticas de privacidad y prácticas de manejo de datos.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '4. Seguridad de los Datos',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Adoptamos medidas técnicas y organizativas para proteger tu información personal contra pérdida, robo y acceso no autorizado. Sin embargo, ninguna transmisión de datos por Internet es completamente segura, por lo que no podemos garantizar la seguridad absoluta.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '5. Menores de Edad',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Esta app no está dirigida a menores de 13 años. No recopilamos intencionadamente información personal de menores. Si eres padre o tutor y crees que tu hijo nos ha proporcionado datos personales, por favor contáctanos para eliminar esa información.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '6. Derechos del Usuario',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Como usuario, puedes solicitar en cualquier momento acceso, corrección o eliminación de los datos que tengamos sobre ti, si corresponde, por favor, contáctanos en:',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // HAY UN CORREO (REDIRECCIONAR PARA ENVIO DE CORREO)
            GestureDetector(
                onTap: () {
                  launchEmail('soporte@vomnoticias.com');
                },
                child: Text('soporte@vomnoticias.com.',
                    style: Theme.of(context).textTheme.titleMedium)),
            Text(
              'También puedes desinstalar la app para dejar de compartir cualquier información de uso.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '7. Cambios en la Política de Privacidad',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Nos reservamos el derecho de modificar esta Política de Privacidad en cualquier momento. Si realizamos cambios importantes, te lo notificaremos dentro de la app. Te recomendamos revisar esta política periódicamente.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '8. Contacto',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            // HAY UN CORREO (REDIRECCIONAR PARA ENVIO DE CORREO)
            Text(
              'Si tienes alguna pregunta o deseas ejercer tus derechos, puedes contactarnos a cualquiera de los siguientes correos:',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            GestureDetector(
                onTap: () {
                  launchEmail('soporte@vomnoticias.com');
                },
                child: Text('soporte@vomnoticias.com.',
                    style: Theme.of(context).textTheme.titleMedium)),
            GestureDetector(
                onTap: () {
                  launchEmail('prensa@vomnoticias.com');
                },
                child: Text('prensa@vomnoticias.com.',
                    style: Theme.of(context).textTheme.titleMedium)),
          ],
        ),
      ),
    );
  }
}

// Función para abrir la aplicación de correo
void launchEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=Default Subject&body=Default body',
  );
  await launchUrl(emailUri);
}
