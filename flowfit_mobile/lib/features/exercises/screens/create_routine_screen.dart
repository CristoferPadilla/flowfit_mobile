import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';
import 'package:flowfit_mobile/features/exercises/widgets/gridview/gridview_exercise.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class CreateRoutineScreen extends StatelessWidget {
  
  const CreateRoutineScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Rutina"),
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
          print('Exercise map: $exerciseMap');
          return Exercise.fromJson(exerciseMap);
        } catch (e) {
          print('Error decoding JSON: $e');
          return null;
        }
      }).where((exercise) => exercise != null).cast<Exercise>().toList(); // Filtra y convierte los elementos a Exercise

      print('Selected exercises: $selectedExercises'); // Imprime la lista de ejercicios después del filtrado
    });
  } else {
    print('No exercises found in shared preferences'); // Imprime un mensaje si no se encuentran ejercicios en las preferencias compartidas
  }
}





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: routineNameController,
            decoration: InputDecoration(labelText: 'Nombre de la rutina'),
          ),
          ElevatedButton(
onPressed: () async {
  final List<Exercise>? exercises = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SelectExercisesScreen(
      selectedExercises: (List<Exercise> selected) {
        // Imprimir los ejercicios seleccionados
        print('Ejercicios seleccionados:');
        for (var exercise in selected) {
          print(exercise.name);
        }
      },
    )),
  );

  if (exercises != null) {
    setState(() {
      selectedExercises = exercises;
    });
  }
},

            child: Text('Seleccionar ejercicios'),
          ),
          Expanded(
            child:ListView.builder(
  itemCount: selectedExercises.length,
  itemBuilder: (context, index) {
    final exercise = selectedExercises[index];
    return ListTile(
      title: Text(exercise.name),
      leading: Image.network(exercise.gifUrl),
      trailing: IconButton(
        icon: Icon(Icons.delete), // Icono para eliminar
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
              // Ejemplo: guardarRutina(routineName, selectedExercises);
              saveRoutine();
            },
            child: Text('Guardar Rutina'),
          ),
        ],
      ),
    );
  }
  
Future<void> saveRoutine() async {
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
  final routineName = routineNameController.text;
  await prefs.setStringList(routineName, routineExercisesJsonString);

  // Limpia la lista de ejercicios seleccionados
  setState(() {
    selectedExercises = [];
  });

  print(routineName);
  print(routineExercisesJsonString);

  // Cierra la pantalla actual y regresa a la pantalla anterior
  Navigator.pop(context);
}




}



class SelectExercisesScreen extends StatelessWidget {
  final Function(List<Exercise>) selectedExercises;

  SelectExercisesScreen({required this.selectedExercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridViewContainer(
        selectedExercises: selectedExercises,
      ),
    );
  }
}
