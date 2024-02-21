import 'package:flowfit_mobile/features/exercises/widgets/containers/container_exercice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Exercise {
  final String name;
  final String gifUrl;
  final dynamic bodyPart;
  final dynamic instructions;

  Exercise({this.bodyPart, this.instructions, required this.name, required this.gifUrl});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      gifUrl: json['gifUrl'],
      bodyPart: json['bodyPart'],
      instructions: json['instructions'],
    );
  }
}

class GridViewContainer extends StatefulWidget {
  const GridViewContainer({Key? key}) : super(key: key);

  @override
  _GridViewContainerState createState() => _GridViewContainerState();
}

class _GridViewContainerState extends State<GridViewContainer> {
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
        print(response.body);
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
    final itemCount = exercises.length < 10 ? exercises.length : 10;

    return _isLoading
        ? const Center(child: CircularProgressIndicator()) 
        : SizedBox(
            height: height * 0.75,
            width: double.infinity,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(itemCount, (index) {
                final exercise = exercises[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContainerExercice(
                    name: exercise.name,
                    gifUrl: exercise.gifUrl,
                    instructions: exercise.instructions is String ? exercise.instructions : exercise.instructions.join(', '),
                    bodyPart:   exercise.bodyPart is String ? exercise.bodyPart : exercise.bodyPart.join(', '),
                  ),
                );
              }),
            ),
          );
  }
}
