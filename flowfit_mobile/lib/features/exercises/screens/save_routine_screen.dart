import 'dart:convert';
import 'package:flowfit_mobile/features/exercises/screens/start_routine_screen.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';

class SavedRoutinesScreen extends StatefulWidget {
  final Function(String)? onRoutineSelected;
  const SavedRoutinesScreen({Key? key, this.onRoutineSelected}) : super(key: key);

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
void _handleRoutineSelection(String selectedRoutineName) {
  // Find the selected routine in the savedRoutines list
  final selectedRoutine = savedRoutines.firstWhere((routine) => routine.name == selectedRoutineName);

  if (selectedRoutine != null) {
    // Call the onRoutineSelected callback from ListCalendary (if provided)
    if (widget.onRoutineSelected != null) {
      widget.onRoutineSelected!(selectedRoutine.name); // Pass the routine name
    }
    Navigator.pop(context); // Close the dialog
  } else {
    // Handle scenario where selected routine is not found (optional)
    print('Error: Selected routine "$selectedRoutineName" not found.');
  }
}
  Future<void> loadSavedRoutines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> savedRoutineKeys = prefs.getKeys().toList();

    final List<SavedRoutine> loadedRoutines = [];

    for (final key in savedRoutineKeys) {
      final dynamic value = prefs.get(key);

      if (value is List<String>) {
        // Existing format, continue as before
        final List<Exercise> routineExercises = value
            .map((exerciseJson) => Exercise.fromJson(jsonDecode(exerciseJson)))
            .toList();

        loadedRoutines.add(SavedRoutine(
          name: key,
          exercises: routineExercises,
          isRemovable: true,
        ));
      } else if (value is List<dynamic>) {
        try {
          final List<Exercise> routineExercises = value
              .map((exerciseData) {
                if (exerciseData is String) {
                  try {
                    final parsedMap =
                        jsonDecode(exerciseData) as Map<String, dynamic>;
                    return Exercise.fromMap(
                        parsedMap); // Or use Exercise.fromJson if available
                  } catch (e) {
                    print('Error: Rutina "$key" tiene formato JSON inválido');
                    // Display message to user about corrupted routine
                    return null;
                  }
                } else if (exerciseData is Map<String, dynamic>) {
                  // Existing logic for maps
                  return Exercise.fromMap(exerciseData);
                } else {
                  // Existing logic for invalid data
                  print('Error: Rutina "$key" contiene datos no válidos');
                  return null;
                }
              })
              .whereType<Exercise>()
              .toList();

          loadedRoutines.add(SavedRoutine(
            name: key,
            exercises: routineExercises,
            isRemovable: true,
          ));
        } catch (e) {
          // Handle conversion error
          print('Error al convertir la rutina "$key": $e');
          // Display a message to the user about the corrupted routine
        }
      } else {
        // Handle other data types (e.g., int, bool)
        print(
            'Error: Rutina "$key" tiene un tipo de dato inesperado: ${value.runtimeType}');
        // Display a message to the user about the corrupted routine
      }
    }

    setState(() {
      savedRoutines = loadedRoutines;
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

  void _showRoutineDetailsDialog(SavedRoutine routine) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rutina: ${routine.name}'),
        content: Text('Ejercicios: ${routine.exercises.length}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          TextButton(
            onPressed: () {
              // Start the routine
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartRoutineScreen(
                    exercises: routine.exercises.whereType<Exercise>().toList(),
                    routineName: routine.name,
                  ),
                ),
              );
            },
            child: const Text('Iniciar'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas Guardadas'),
      ),
      body: savedRoutines.isEmpty
          ? const Center(
              child: Text('No hay rutinas válidas guardadas'),
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
                    title: Text('Rutina $routineName', style: FontStyle.titleTextStyle.copyWith(fontSize: 17),),
                    subtitle: Text('Ejercicios: ${exercises.length}',style: FontStyle.subtitleTextStyle.copyWith(fontSize: 15),),
                    leading: const Icon(
                      Icons.panorama_fish_eye_outlined,
                      size: 16,
                      color: PrimaryTheme.secundaryColor,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: const Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5)),
                    onTap: () async {
                      // Filter out null elements for safe assignment
                      final parsedExercises =
                          exercises.whereType<Exercise>().toList();

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
