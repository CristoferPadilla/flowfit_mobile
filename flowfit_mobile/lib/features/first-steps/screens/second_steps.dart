import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/first-steps/widget/slider/custome_slider.dart';
import 'package:flowfit_mobile/features/first-steps/widget/title/custom_title.dart';
import 'package:flowfit_mobile/features/profile/widget/form/profile_form_screen.dart';
import 'package:flutter/material.dart';

class SecondStepScreen extends StatefulWidget {
  const SecondStepScreen({Key? key}) : super(key: key);

  @override
  State<SecondStepScreen> createState() => _SecondStepScreenState();
}

class _SecondStepScreenState extends State<SecondStepScreen> {
  List<Map<String, int>> preguntas = [
    {'¿Cuál es tu nivel de experiencia en entrenamiento de fuerza?': 0},
    {'¿Qué tipo de ejercicios prefieres hacer?': 1},
    {'¿Con qué frecuencia haces ejercicio?': 2},
    {'¿Cuál es tu objetivo principal al hacer ejercicio?': 3},
    {'¿Qué tipo de dieta sigues?': 4},
    {
      '¿Tienes alguna lesión o condición médica que afecte tu capacidad para hacer ejercicio?': 5
    },
    {'¿Cómo calificarías tu nivel de motivación para hacer ejercicio?': 6},
    {'¿Qué tan importante es para ti medir tus progresos?': 7},
    {'¿Qué tipo de ambiente de entrenamiento prefieres?': 8},
    {'¿Cuál es tu deporte o actividad física favorita?': 9},
  ];

  int currentIndex = 0;
  int total = 0; // Variable to accumulate the sum of responses
  bool encuestaTerminada = false;

  void avanzarPregunta(int valorRespuesta) {
    setState(() {
      total += valorRespuesta;
      currentIndex++;

      if (currentIndex < preguntas.length) {
        preguntas[currentIndex]['valor'] = valorRespuesta;
      } else {
        // Handle end of questionnaire
        enviarResultadoAPI();
        reiniciarEncuesta();
        setState(() {
          encuestaTerminada = true; // Show the message after actions
        });
      }
    });
  }

  void reiniciarEncuesta() {
    currentIndex = 0;
    total = 0;
    for (var pregunta in preguntas) {
      pregunta['valor'] = 1;
    }
  }

  void enviarResultadoAPI() {
    // Implement logic to send total to your API
    print('Enviando resultado total a la API: $total');
  }

  @override
  Widget build(BuildContext context) {
    String valorRespuesta = preguntas[currentIndex]['valor']?.toString() ?? '0';

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomTitleSteps(
              title: '¡Ayúdanos a evaluarte !',
              description:
                  'Con tu conocimiento y tu esfuerzo, podremos ayudarte a alcanzar tus metas. Por favor, completa el siguiente cuestionario para conocerte un poco más',
            ),
            const SizedBox(height: 20),
            if (encuestaTerminada)
              const Text(
                'Evaluando tu nivel en base a tus respuestas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            else ...[ // Use the spread operator (...) to include multiple widgets conditionally
              if (currentIndex < preguntas.length) // Only show question if not completed
                Text(
                  preguntas[currentIndex].keys.first,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),
              if (currentIndex < preguntas.length) // Only show slider if not completed and not at the end
                CustomSlider(
                  value: double.tryParse(valorRespuesta)?.clamp(1.0, 3.0) ?? 1.0,
                  onChanged: (value) {
                    print("Valor seleccionado mientras se arrastra: $value");
                  },
                  onChangeEnd: (value) {
                    print("Valor seleccionado después de soltar el slider: $value");
                    avanzarPregunta(value.toInt());
                  },
                ),
            ],
            const Spacer(),
            const SectionButtons(
              isBackButtonVisible: true,
              screen: ProfileFormScreen(),
              isFrontButtonVisible: true,
            )
          ],
        ),
      ),
    );
  }
}
