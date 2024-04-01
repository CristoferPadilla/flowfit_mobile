import 'package:flowfit_mobile/features/exercises/widgets/containers/container_exercice.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
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
  late List<Exercise> filteredExercises = [];
  late List<Exercise> exercises = [];
  bool _isLoading = true;
  TextEditingController searchController = TextEditingController();

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

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          exercises = responseData.map((json) => Exercise.fromJson(json)).toList();
          filteredExercises = List.from(exercises); // Actualizar filteredExercises con la lista completa de ejercicios
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterExercises(String searchTerm) {
    setState(() {
      filteredExercises = exercises.where((exercise) {
        return exercise.name.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            controller: searchController,
            onChanged: _filterExercises,
            decoration: const InputDecoration(
              hintText: 'Buscar ejercicio',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        if (!_isLoading)
          Expanded(
            child: ListView.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContainerExercice(
                    name: exercise.name,
                    gifUrl: exercise.gifUrl,
                    instructions: exercise.instructions is String ? exercise.instructions : exercise.instructions.join(', '),
                    bodyPart: exercise.bodyPart is String ? exercise.bodyPart : exercise.bodyPart.join(', '),
                  ),
                );
              },
            ),
          ),
        if (_isLoading || filteredExercises.isEmpty)
          Expanded(
            child: Center(
              child: _isLoading ? const CircularProgressIndicator() : const Text('No se encontraron ejercicios'),
            ),
          ),
      ],
    );
  }
}
