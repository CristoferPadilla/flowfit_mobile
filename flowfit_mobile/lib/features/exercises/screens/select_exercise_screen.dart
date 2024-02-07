import 'package:flowfit_mobile/features/exercises/widgets/gridview/gridview_exercise.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class SelectExercisesScreen extends StatelessWidget {
  const SelectExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: PrimaryTheme.backgroundColor.withOpacity(0.9),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('¡Encuentra el mejor ejercicio para ti!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: SearchBar(
                      leading: Icon(Icons.search),
                      hintText: 'Buscar ejercicio',
                    ),
                  ),
                  GridViewContainer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}