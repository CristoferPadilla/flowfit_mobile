import 'package:flowfit_mobile/features/exercises/widgets/containers/container_exercice.dart';
import 'package:flutter/material.dart';

class GridViewContainer extends StatelessWidget {
  
  const GridViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
  final List<String> bodyPart = [
    'Flexiones de pecho',
    'Press de hombros',
    'Curl de bíceps',
    'Tríceps en polea',
    'Flexiones de pecho',
    'Press de hombros',
    'Curl de bíceps',
    'Tríceps en polea',
    'Flexiones de pecho',
    'Press de hombros',
    'Curl de bíceps',    
  ];
    final height = MediaQuery.of(context).size.height;
        final itemCount = bodyPart.length < 10 ? bodyPart.length : 10;

    return SizedBox(
      height: height*0.75 ,
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(itemCount, (index) {
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