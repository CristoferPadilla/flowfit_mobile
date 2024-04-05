import 'dart:convert';
import 'package:flowfit_mobile/features/exercises/screens/start_routine_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';

class SavedRoutinesScreen extends StatefulWidget {
  const SavedRoutinesScreen({Key? key}) : super(key: key);

  @override
  _SavedRoutinesScreenState createState() => _SavedRoutinesScreenState();
}

class _SavedRoutinesScreenState extends State<SavedRoutinesScreen> {
  late List<Map<String, dynamic>> savedRoutines;

  @override
  void initState() {
    super.initState();
    savedRoutines = [];
    loadSavedRoutines();
  }

Future<void> loadSavedRoutines() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> savedRoutineKeys = prefs.getKeys().toList();

  final List<Map<String, dynamic>> loadedRoutines = [];

  for (final key in savedRoutineKeys) {
    final dynamic value = prefs.get(key);
    if (value is List<String>) {
      final List<Exercise> routineExercises = value
          .map((exerciseJson) => Exercise.fromJson(jsonDecode(exerciseJson)))
          .toList();

      // Convertir manualmente los ejercicios a una lista de Maps
      final List<Map<String, dynamic>> exercisesJson = routineExercises.map((exercise) {
        return {
          'name': exercise.name,
          'gifUrl': exercise.gifUrl,
          'bodyPart': exercise.bodyPart,
          'instructions': exercise.instructions,
          // Agregar otros atributos según sea necesario
        };
      }).toList();

      loadedRoutines.add({
        'name': key, // Usamos la clave como nombre de la rutina
        'exercises': exercisesJson,
      });
    } else {
      print('Error: El valor almacenado para la clave $key no es una lista de cadenas');
    }
  }

  setState(() {
    savedRoutines = loadedRoutines;
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutinas Guardadas'),
      ),
      body: savedRoutines.isEmpty
          ? Center(
              child: Text('No hay rutinas guardadas'),
            )
          : ListView.builder(
              itemCount: savedRoutines.length,
              itemBuilder: (context, index) {
                final routine = savedRoutines[index];
                final routineName = routine['name'];
                final List<dynamic> exercises = routine['exercises'] ?? [];

                return ListTile(
                  title: Text('Rutina $routineName'),
                  subtitle: Text('Ejercicios: ${exercises.length}'),
onTap: () async {
  final routineName = routine['name'];
  final List<Exercise> parsedExercises = exercises.map((exerciseJson) {
    final Map<String, dynamic> exerciseMap = Map<String, dynamic>.from(exerciseJson);
    return Exercise.fromJson(exerciseMap);
  }).toList();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StartRoutineScreen(exercises: parsedExercises, routineName: routineName),
    ),
  );
},

                );
              },
            ),
    );
  }
}
