import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/first-steps/widget/slider/custome_slider.dart';
import 'package:flowfit_mobile/features/first-steps/widget/title/custom_title.dart';
import 'package:flowfit_mobile/features/profile/widget/form/profile_form_screen.dart';
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
    {'¿Tienes alguna lesión o condición médica que afecte tu capacidad para hacer ejercicio?': 5},
    {'¿Cómo calificarías tu nivel de motivación para hacer ejercicio?': 6},
    {'¿Qué tan importante es para ti medir tus progresos?': 7},
    {'¿Qué tipo de ambiente de entrenamiento prefieres?': 8},
    {'¿Cuál es tu deporte o actividad física favorita?': 9},
  ];

  int currentIndex = 0;
  int total = 0;
  bool encuestaTerminada = false;
  late String accessToken;
  late String userId;

  @override
  void initState() {
    super.initState();
    obtenerDatosUsuario();
  }

  Future<void> obtenerDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    userId = prefs.getString('id') ?? '';
  }

  Future<void> avanzarPregunta(int valorRespuesta) async {
    setState(() {
      total += valorRespuesta;
      currentIndex++;

      if (currentIndex < preguntas.length) {
        preguntas[currentIndex]['valor'] = valorRespuesta;
      } else {
        enviarResultadoAPI();
        reiniciarEncuesta();
        setState(() {
          encuestaTerminada = true;
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

  Future<void> enviarResultadoAPI() async {
    String nivel;

    if (total >= 0 && total <= 10) {
      nivel = 'Beginner';
    } else if (total >= 11 && total <= 20) {
      nivel = 'Intermediate';
    } else {
      nivel = 'Advanced';
    }

    String url = 'https://api-zydf.onrender.com/members/$userId';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, String>{
          'level': nivel,
        }),
      );

      if (response.statusCode == 200) {
        print('Nivel enviado correctamente a la API: $nivel');
      } else {
        print('Error al enviar el nivel a la API');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
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
            else ...[
              if (currentIndex < preguntas.length)
                Text(
                  preguntas[currentIndex].keys.first,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),
              if (currentIndex < preguntas.length)
                CustomSlider(
                  value: double.tryParse(valorRespuesta)?.clamp(1.0, 3.0) ?? 1.0,
                  onChanged: (value) {},
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
