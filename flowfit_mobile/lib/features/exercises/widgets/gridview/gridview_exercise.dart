import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/features/exercises/widgets/containers/container_exercice.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GridViewContainer extends StatefulWidget {
  final Function(List<Exercise>) selectedExercises;

  const GridViewContainer({Key? key,required this.selectedExercises}) : super(key: key);

  @override
  _GridViewContainerState createState() => _GridViewContainerState();
}

class _GridViewContainerState extends State<GridViewContainer> {
  late List<Exercise> filteredExercises = [];
  late List<Exercise> selectedExercises = [];
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
          filteredExercises = List.from(exercises);
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

  void _filterExercises(String searchTerm) async {
    try {
      final response = await http.get(
        Uri.parse('https://exercisedb.p.rapidapi.com/exercises/name/$searchTerm'),
        headers: {
          'X-RapidAPI-Key': '4605281141msh0e98e818c927662p1348bfjsn25e19f56beb8',
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          filteredExercises = responseData.map((json) => Exercise.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Ejercicios"),
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  cursorColor: PrimaryTheme.secundaryColor,
                  controller: searchController,
                  onChanged: _filterExercises,
                  decoration: InputDecoration(
                    hoverColor: PrimaryTheme.secundaryColor,
                    hintText: 'Buscar ejercicio',
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryTheme.secundaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: PrimaryTheme.secundaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              if (!_isLoading && filteredExercises.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = filteredExercises[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:GestureDetector(
  onTap: () {
    setState(() {
      if (!selectedExercises.contains(exercise)) {
        selectedExercises.add(exercise);
      } else {
        selectedExercises.remove(exercise);
      }
    });
    widget.selectedExercises(selectedExercises);
  },
  child: ContainerExercice(
    name: exercise.name,
    gifUrl: exercise.gifUrl,
    instructions: exercise.instructions is String
        ? exercise.instructions
        : exercise.instructions.join(', '),
    bodyPart: exercise.bodyPart is String
        ? exercise.bodyPart
        : exercise.bodyPart.join(', '),
    isSelected: selectedExercises.contains(exercise),
     onTap: () {
    setState(() {
      if (selectedExercises.contains(exercise)) {
        selectedExercises.remove(exercise);
      } else {
        selectedExercises.add(exercise);
      }
    });
       }, 
  ),
),
                      );
                    },
                  ),
                ),
              if (_isLoading || filteredExercises.isEmpty)
                Expanded(
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('No se encontraron ejercicios'),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
print(selectedExercises.map((exercise) => exercise.name).toList());

 Navigator.pop(context, selectedExercises);
              },
              label: const Text('Confirmar selección'),
              icon: const Icon(Icons.check),
              backgroundColor: PrimaryTheme.secundaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
