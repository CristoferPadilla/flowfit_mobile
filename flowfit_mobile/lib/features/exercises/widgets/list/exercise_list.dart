import 'package:flowfit_mobile/features/exercises/widgets/gridview/gridview_exercise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flowfit_mobile/features/exercises/widgets/containers/custom_list_container.dart';

class ExerciseListView extends StatefulWidget {
  const ExerciseListView({Key? key}) : super(key: key);

  @override
  _ExerciseListViewState createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  late List<Exercise> exercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      final response = await http.get(
        Uri.parse('https://exercisedb.p.rapidapi.com/exercises'),
        headers: {
          'X-RapidAPI-Key': '4605281141msh0e98e818c927662p1348bfjsn25e19f56beb8',
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
        },
      );

      if (mounted) {
        if (response.statusCode == 200) {
          final List<dynamic> responseData = json.decode(response.body);
          setState(() {
            exercises = responseData.map((json) => Exercise.fromJson(json)).toList();
            _isLoading = false;
          });
        } else {
          throw Exception('Failed to load exercises');
        }
      }
    } catch (error) {
      print(error);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.68,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _isLoading ? 1 : (exercises.length < 5 ? exercises.length : 5),
        itemBuilder: (context, index) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final exercise = exercises[index];
            return CustomListContainer(
              name: exercise.name,
              gifUrl: exercise.gifUrl,
              instruction: exercise.instructions is String ? exercise.instructions : exercise.instructions.join(', '),
              bodyPart:   exercise.bodyPart is String ? exercise.bodyPart : exercise.bodyPart.join(', '),
            );
          }
        },
      ),
    );
  }
}
