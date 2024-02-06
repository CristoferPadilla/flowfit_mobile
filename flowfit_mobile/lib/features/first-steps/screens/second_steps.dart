import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/first-steps/widget/slider/custome_slider.dart';
import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';

class SecondStepScreen extends StatefulWidget {
  const SecondStepScreen({Key? key}) : super(key: key);

  @override
  State<SecondStepScreen> createState() => _SecondStepScreenState();
}

class _SecondStepScreenState extends State<SecondStepScreen> {
  double _valor = 1; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '¡Ayúdanos a evaluarte !',
                style: FontStyle.titleTextStyle.copyWith(
                  color: PrimaryTheme.secundaryColor,
                  fontSize: 50,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Con tu conocimiento y tu esfuerzo, podremos ayudarte a alcanzar tus metas. Por favor, completa el siguiente cuestionario para conocerte un poco más.',
                style: FontStyle.descriptionTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            CustomSlider(
              title: '¿Cuál es tu nivel de experiencia en entrenamiento de fuerza?',
              value: _valor, 
              onChanged: (value) {
                setState(() {
                  _valor = value; 
                });
              },
            ),
            const Spacer(),
            const SectionButtons(isBackButtonVisible: true, screen: NavBar())
          ],
        ),
      ),
    );
  }
}
