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
  late List<SavedRoutine> savedRoutines;

  @override
  void initState() {
    super.initState();
    savedRoutines = [];
    loadSavedRoutines();
  }

  Future<void> loadSavedRoutines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> savedRoutineKeys = prefs.getKeys().toList();

    final List<SavedRoutine> loadedRoutines = [];

    for (final key in savedRoutineKeys) {
      final dynamic value = prefs.get(key);
      if (value is List<String>) {
        final List<Exercise> routineExercises = value
            .map((exerciseJson) => Exercise.fromJson(jsonDecode(exerciseJson)))
            .toList();

        loadedRoutines.add(SavedRoutine(
          name: key,
          exercises: routineExercises,
          isRemovable: true, // Mark routine as removable
        ));
      }
    }

    setState(() {
      savedRoutines = loadedRoutines; // Update with List<SavedRoutine>
    });
  }

  Future<void> removeRoutine(String routineName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(routineName);

    setState(() {
      savedRoutines.removeWhere((routine) => routine.name == routineName);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rutina "$routineName" eliminada')),
    );
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
                final routineName = routine.name;
                final List<Exercise> exercises = routine.exercises;

                return Dismissible(
                  key: Key(routineName),
                  onDismissed: (direction) => removeRoutine(routineName),
                  child: ListTile(
                    title: Text('Rutina $routineName'),
                    subtitle: Text('Ejercicios: ${exercises.length}'),
                    onTap: () async {
                      final parsedExercises = exercises.toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartRoutineScreen(
                            exercises: parsedExercises,
                            routineName: routineName,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class SavedRoutine {
  String name;
  List<Exercise> exercises;
  bool isRemovable;

  SavedRoutine({
    required this.name,
    required this.exercises,
    required this.isRemovable,
  });
}
