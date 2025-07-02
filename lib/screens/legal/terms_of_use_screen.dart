import 'package:flutter/material.dart';
import 'package:vom_app/widgets/navigation/appbars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vom_app/screens/legal/privacy_policy_screen.dart';

class TerminosUsoScreen extends StatelessWidget {
  const TerminosUsoScreen({Key? key}) : super(key: key);

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
              child: Text('Condiciones de Uso',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
            const SizedBox(height: 8.0),
            Text(
              // Agregar la fecha de la version actual de la aplicacion
              'Última actualización:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
                'Bienvenido a “VOM Noticias Móvil”. Al descargar, instalar y utilizar nuestra aplicación, aceptas cumplir con los términos y condiciones descritos a continuación. Por favor, léelos detenidamente.',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            Text(
              '1. Aceptación de los Términos',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Al acceder y utilizar “VOM Noticias Móvil” aceptas estar sujeto a estas Condiciones de Uso. Si no estás de acuerdo con alguna parte de estas condiciones, no deberías utilizar nuestra aplicación.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '2. Uso de la Aplicación',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '• Edad mínima: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text:
                        'Debes tener al menos 18 años (o la mayoría de edad legal en tu país) para usar esta aplicación.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '• Cuenta: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text:
                        'Eres responsable de la seguridad y la confidencialidad de la información de tu cuenta. Debes notificar de inmediato cualquier uso no autorizado de tu cuenta.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '• Comportamiento Prohibido: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text:
                        'No debes utilizar la aplicación para fines ilícitos, distribuir malware, o actuar de manera que dañe a otros usuarios o la infraestructura de “VOM Noticias Móvil”.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),
            Text(
              '3. Contenido de Terceros',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'La aplicación puede contener enlaces y contenido de terceros. No somos responsables de la veracidad, integridad o calidad de este contenido, y el uso de estos enlaces es bajo tu propio riesgo.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '4. Propiedad Intelectual',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Todo el contenido, diseño, logos, y materiales disponibles en “VOM Noticias Móvil” son propiedad de “Grupo Infotur” o sus licenciantes. Queda prohibido el uso no autorizado de cualquier material de la aplicación sin previo consentimiento escrito.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '5. Privacidad',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(
                    text:
                        'Para más información sobre cómo manejamos tus datos personales, consulta nuestra ',
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PoliticaPrivacidadScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Política de Privacidad.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            Text(
              '6. Modificaciones',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Nos reservamos el derecho de modificar o actualizar estas Condiciones de Uso en cualquier momento. Cualquier cambio será efectivo una vez que se publique en esta sección. Te recomendamos que revises estas condiciones periódicamente para estar informado.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '7. Limitación de Responsabilidad',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'La aplicación se ofrece "tal cual" y "según disponibilidad". No garantizamos que el servicio sea ininterrumpido, seguro o libre de errores. Grupo Infotur no se hace responsable de cualquier daño directo, indirecto, incidental, o consecuente que surja del uso o la incapacidad de usar la aplicación. El uso de la aplicación es bajo tu propio riesgo.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '8. Terminación',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Nos reservamos el derecho de suspender o terminar tu acceso a “VOM Noticias Móvil” en cualquier momento si violas estas Condiciones de Uso o si consideramos que es necesario por razones de seguridad.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '9. Ley Aplicable',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Estas Condiciones de Uso se regirán e interpretarán de acuerdo con las leyes de los Estados Unidos Mexicanos y, en particular, las leyes aplicables del estado de Morelos. Cualquier disputa o controversia que surja en relación con estas condiciones se someterá a la jurisdicción de los tribunales competentes en la ciudad de Cuernavaca, Morelos, renunciando expresamente a cualquier otro fuero que pudiera corresponder.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              '10. Contacto',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            // Modificar style (interactuable)
            Text(
              'Si tienes alguna pregunta o inquietud sobre estas Condiciones de Uso, puedes contactarnos en:',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
