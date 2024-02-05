import 'package:flowfit_mobile/features/exercises/widgets/containers/container_exercice.dart';
import 'package:flutter/material.dart';

class GridViewContainer extends StatelessWidget {
  
  const GridViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
      final List<String> bodyPart = ['Pecho', 'Hombro', 'Brazo', 'Espalda', 'Pierna', 'Abdomen', 'Glúteos', 'Cardio', 'Flexibilidad', 'Cuerpo completo'];

    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height*0.75 ,
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child:  ContainerExercice(
              bodyPart: bodyPart[index],
            )
          );
        }),
      )
    );
  }
}