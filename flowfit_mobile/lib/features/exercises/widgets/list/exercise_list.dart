import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';
import 'package:flowfit_mobile/features/exercises/widgets/containers/custom_list_container.dart';
import 'package:flutter/material.dart';

class ExerciseListView extends StatelessWidget {
  final List<Exercise> exercises;

  const ExerciseListView({Key? key, required this.exercises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.68,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return CustomListContainer(
            name: exercise.name,
            gifUrl: exercise.gifUrl,
            instruction: exercise.instructions is String ? exercise.instructions : exercise.instructions.join(', '),
            bodyPart: exercise.bodyPart is String ? exercise.bodyPart : exercise.bodyPart.join(', '),
          );
        },
      ),
    );
  }
}
