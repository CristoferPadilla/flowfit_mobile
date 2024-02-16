import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/first-steps/widget/slider/custome_slider.dart';
import 'package:flowfit_mobile/features/first-steps/widget/title/custom_title.dart';
import 'package:flowfit_mobile/features/profile/screens/profile_form_screen.dart';
import 'package:flutter/material.dart';

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
            const CustomTitleSteps(title: '¡Ayúdanos a evaluarte !',
            description: 'Con tu conocimiento y tu esfuerzo, podremos ayudarte a alcanzar tus metas. Por favor, completa el siguiente cuestionario para conocerte un poco más',) ,
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
            const SectionButtons(isBackButtonVisible: true, screen: ProfileFormScreen(), isFrontButtonVisible: true,)
          ],
        ),
      ),
    );
  }
}

