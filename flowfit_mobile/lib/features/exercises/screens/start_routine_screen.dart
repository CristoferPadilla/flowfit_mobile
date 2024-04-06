import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';
import 'package:flowfit_mobile/features/exercises/widgets/headers/custome_exercise_header.dart';
import 'package:flowfit_mobile/features/exercises/widgets/list/exercise_list.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/app_resources.dart';

class StartRoutineScreen extends StatelessWidget {
  final List<Exercise> exercises;
  final String routineName;

  const StartRoutineScreen({Key? key, required this.exercises, required this.routineName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appResource = AppResource();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomExerciseHeader(appResource: appResource.ejercicio3, name: routineName),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('EJERCICIOS EN LA LISTA: ${exercises.length}', style: FontStyle.descriptionTextStyle.copyWith(color: Colors.black)),
            ),
            ExerciseListView(exercises: exercises), // Pass the exercises list directly
          ],
        ),
      ),
    );
  }
}
