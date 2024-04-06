import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';
import 'package:flowfit_mobile/features/exercises/widgets/gridview/gridview_exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRoutineScreen extends StatelessWidget {
  const CreateRoutineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Rutina"),
      ),
      body: CreateRoutineForm(),
    );
  }
}

class CreateRoutineForm extends StatefulWidget {
  const CreateRoutineForm({Key? key}) : super(key: key);

  @override
  _CreateRoutineFormState createState() => _CreateRoutineFormState();
}

class _CreateRoutineFormState extends State<CreateRoutineForm> {
  late List<Exercise> selectedExercises = [];
  TextEditingController routineNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSelectedExercises(); // Cargar ejercicios seleccionados al iniciar la pantalla
  }

  Future<void> loadSelectedExercises() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? selectedExercisesJson = prefs.getStringList('selectedExercises');
    if (selectedExercisesJson != null) {
      setState(() {
        selectedExercises = selectedExercisesJson.map((json) {
          try {
            final Map<String, dynamic> exerciseMap = jsonDecode(json);
            return Exercise.fromJson(exerciseMap);
          } catch (e) {
            print('Error decoding JSON: $e');
            return null;
          }
        }).whereType<Exercise>().toList(); // Filtra y convierte los elementos a Exercise
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: routineNameController,
            decoration: const InputDecoration(labelText: 'Nombre de la rutina'),
          ),
          ElevatedButton(
            onPressed: () async {
              final List<Exercise>? exercises = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectExercisesScreen(
                    selectedExercises: List.of(selectedExercises), // Pasar una copia de la lista
                  ),
                ),
              );

              if (exercises != null) {
                setState(() {
                  selectedExercises = exercises;
                });
              }
            },
            child: const Text('Seleccionar ejercicios'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedExercises.length,
              itemBuilder: (context, index) {
                final exercise = selectedExercises[index];
                return ListTile(
                  title: Text(exercise.name),
                  leading: Image.network(exercise.gifUrl),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete), // Icono para eliminar
                    onPressed: () {
                      setState(() {
                        selectedExercises.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final routineName = routineNameController.text;
              saveRoutine(routineName);
            },
            child: const Text('Guardar Rutina'),
          ),
        ],
      ),
    );
  }

  Future<void> saveRoutine(String routineName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  
    // Convierte la lista de ejercicios en una lista de mapas de JSON
    final List<Map<String, dynamic>> routineExercisesJson = selectedExercises.map((exercise) {
      return {
        'name': exercise.name,
        'gifUrl': exercise.gifUrl,
        'bodyPart': exercise.bodyPart,
        'instructions': exercise.instructions,
      };
    }).toList();
    
    // Convierte la lista de mapas de JSON en una lista de JSON
    final List<String> routineExercisesJsonString = routineExercisesJson.map((exerciseMap) {
      return jsonEncode(exerciseMap);
    }).toList();
  
    // Guarda la rutina en SharedPreferences con el nombre de la rutina como clave
    await prefs.setStringList(routineName, routineExercisesJsonString);
  
    // Limpia la lista de ejercicios seleccionados
    setState(() {
      selectedExercises = [];
    });
  
    // Cierra la pantalla actual y regresa a la pantalla anterior
    Navigator.pop(context);
  }
}

class SelectExercisesScreen extends StatelessWidget {
  final List<Exercise> selectedExercises;

  const SelectExercisesScreen({Key? key, required this.selectedExercises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridViewContainer(
        selectedExercises: selectedExercises,
      ),
    );
  }
}
