import 'package:flowfit_mobile/core/data/data_source/exercise/exercise.dart';
import 'package:flowfit_mobile/features/exercises/widgets/containers/container_exercice.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GridViewContainer extends StatefulWidget {
  final List<Exercise> selectedExercises;

  const GridViewContainer({Key? key, required this.selectedExercises}) : super(key: key);

  @override
  _GridViewContainerState createState() => _GridViewContainerState();
}

class _GridViewContainerState extends State<GridViewContainer> {
  late List<Exercise> filteredExercises = [];
  late List<Exercise> selectedExercises;
  String? selectedEquipment; // Equipment filter state

  @override
  void initState() {
    super.initState();
    selectedExercises = List.from(widget.selectedExercises);
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
          filteredExercises = responseData.map((json) => Exercise.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (error) {
      print(error);
    }
  }

  void _filterExercises(String searchTerm) async {
    try {
      final url = selectedEquipment != null
          ? 'https://exercisedb.p.rapidapi.com/exercises/equipment/$selectedEquipment'
          : 'https://exercisedb.p.rapidapi.com/exercises/name/$searchTerm';
      final response = await http.get(
        Uri.parse(url),
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
                  onChanged: (value) {
                    _filterExercises(value); // Trigger filter with search term
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar ejercicio (o filtrar por equipo)',
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
              // Equipment filter dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Equipment:', style: TextStyle(color: Colors.black87)),
                    DropdownButton<String>(
                      value: selectedEquipment,
                      hint: const Text('Filtrar por equipo'),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Sin filtro'),
                        ),
                        ...equipmentList.map((equipment) => DropdownMenuItem(
                          value: equipment,
                          child: Text(equipment),
                        )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedEquipment = value;
                          _filterExercises(''); // Trigger filter with updated equipment
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (filteredExercises.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = filteredExercises[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!selectedExercises.contains(exercise)) {
                                selectedExercises.add(exercise);
                              } else {
                                selectedExercises.remove(exercise);
                              }
                            });
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
              if (filteredExercises.isEmpty)
                Expanded(
                  child: Center(
                    child: Text('No se encontraron ejercicios'),
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

