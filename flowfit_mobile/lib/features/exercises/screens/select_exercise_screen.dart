import 'package:flowfit_mobile/features/exercises/widgets/gridview/gridview_exercise.dart';
import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';
import 'package:flowfit_mobile/features/home/widget/profile/icon_profile.dart';
import 'package:flutter/material.dart';

class SelectExercisesScreen extends StatelessWidget {
  const SelectExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        bottomNavigationBar: NavBar(),
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('Nivel: Principiante', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('¡Encuentra el mejor ejercicio para ti!', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                GridViewContainer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}