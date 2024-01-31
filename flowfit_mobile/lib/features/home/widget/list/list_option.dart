import 'package:flowfit_mobile/features/home/widget/containers/option_containers.dart';
import 'package:flutter/material.dart';

class ListOption extends StatelessWidget {
  const ListOption({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<Map<String, String>> bodyParts = [
      {'bodyArea': 'Pecho', 'level': 'Principiante', 'image': AppResource().ejercicio1},
      {'bodyArea': 'Espalda', 'level': 'Intermedio', 'image': AppResource().ejercicio2},
      {'bodyArea': 'Piernas', 'level': 'Avanzado', 'image': AppResource().ejercicio3},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height * 0.6,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: bodyParts.length,
          itemBuilder: (context, index) {
            return OptionContainer(
              url: bodyParts[index]['image']!,
              bodyArea: bodyParts[index]['bodyArea']!,
              level: bodyParts[index]['level']!,
            );
          },
        ),
      ),
    );
  }
}

class AppResource{

  final String ejercicio1 = 'assets/jpg/Ejercicio1.jpeg';
  final String ejercicio2 = 'assets/jpg/Ejercicio2.jpeg';
  final String ejercicio3 = 'assets/jpg/Ejercicio3.jpeg';
}