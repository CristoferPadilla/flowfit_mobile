import 'package:flowfit_mobile/features/exercises/widgets/containers/body_parts_container.dart';
import 'package:flutter/material.dart';

class BodyPartList extends StatelessWidget {
   BodyPartList({super.key});

  final List<Map<String, String>> bodyParts = [
    {'part': 'Piernas', 'description': 'Puros ejercicios para piernas'},
    {'part': 'Brazos', 'description': 'Ejercicios para fortalecer los brazos'},
    {'part': 'Hombros', 'description': 'Ejercicios para trabajar los hombros'},
    {'part': 'Glúteos', 'description': 'Ejercicios para tonificar los glúteos'},
    {'part': 'Antebrazos', 'description': 'Ejercicios para trabajar los antebrazos'},
    {'part': 'Espalda', 'description': 'Ejercicios para trabajar la espalda'},
    {'part': 'Glúteos', 'description': 'Ejercicios para tonificar los glúteos'},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height * 0.8,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: bodyParts.length,
          itemBuilder: (context, index) {
            final part = bodyParts[index];
            return ContainerExerciseBodyParts(
              bodypart: part['part']!,
              subtitle: part['description']!,
            );
          },
        ),
      ),
    );
  }
}
