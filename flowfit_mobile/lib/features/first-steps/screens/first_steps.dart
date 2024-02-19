import 'package:flowfit_mobile/features/first-steps/screens/second_steps.dart';
import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class FirstStepsScreen extends StatelessWidget {
  const FirstStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: PrimaryTheme.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('¡Bienvenido',
                      style: FontStyle.titleTextStyle.copyWith(
                          color: PrimaryTheme.secundaryColor, fontSize: 60)),
                  Text('a',
                      style: FontStyle.titleTextStyle.copyWith(
                          color: PrimaryTheme.secundaryColor, fontSize: 60)),
                  Text('FlowFit!',
                      style: FontStyle.titleTextStyle.copyWith(
                          color: PrimaryTheme.secundaryColor, fontSize: 60)),
                          
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Descubre una nueva forma de cuidar tu salud y bienestar. FlowFit te ofrece herramientas para gestionar tus actividades de ejercicio y mantener un control saludable de tu alimentación.',
                style: FontStyle.descriptionTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
                const Spacer(),               
                const SectionButtons(isBackButtonVisible: false, screen: SecondStepScreen(),isFrontButtonVisible: true,)
          ],
        ),
      ),
    );
  }
}
