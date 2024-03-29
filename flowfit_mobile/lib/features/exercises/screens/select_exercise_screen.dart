import 'package:flowfit_mobile/features/exercises/screens/create_routine_screen.dart';
import 'package:flowfit_mobile/features/exercises/widgets/gridview/gridview_exercise.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class SelectExercisesScreen extends StatelessWidget {
  const SelectExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateRoutineScreen(isNewRoutine: true,)),
            );
          },
          label: const Text('Confirmar selección'),
          icon: const Icon(Icons.check),
          backgroundColor: PrimaryTheme.secundaryColor, 
        ),        appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
          title: const Text('¡Es hora de tener buena técnica!', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
        ),
        backgroundColor: Colors.grey.shade100,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: SearchBar(
                      textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                      surfaceTintColor: MaterialStatePropertyAll(Colors.white),
                      overlayColor: MaterialStatePropertyAll(PrimaryTheme.secundaryColor),
                      backgroundColor: MaterialStatePropertyAll(
                        PrimaryTheme.secundaryColor
                      ),
                      leading: Icon(Icons.search,color: Colors.white,),
                      hintText: 'Buscar ejercicio',
                    ),
                  ),
                  GridViewContainer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}