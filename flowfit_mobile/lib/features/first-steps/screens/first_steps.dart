import 'package:flowfit_mobile/features/first-steps/widget/dialog/googlemaps_dialog.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class FirstStepsScreen extends StatelessWidget {
  const FirstStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PrimaryTheme.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('¡Bienvenido a FlowFit!',
                  style: FontStyle.titleTextStyle.copyWith(
                      color: PrimaryTheme.secundaryColor, fontSize: 50)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Descubre una nueva forma de cuidar tu salud y bienestar. FlowFit te ofrece herramientas para gestionar tus actividades de ejercicio y mantener un control saludable de tu alimentación.',
                style: FontStyle.descriptionTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Por favor, selecciona el gimnasio donde te ejercitas.',
                style: FontStyle.descriptionTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const GoogleMapsDialog();
                      },
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: PrimaryTheme.secundaryColor,
                  ),
                  child: Row(children: [
                    const Icon(Icons.search),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Seleccionar gimnasio',
                        style: FontStyle.buttonTextStyle.copyWith(
                          color: Colors.white,
                        )),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
