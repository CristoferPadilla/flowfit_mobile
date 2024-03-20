import 'package:flowfit_mobile/features/exercises/screens/select_exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';

class CreateRoutineScreen extends StatelessWidget {
  const CreateRoutineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Rutinas",
            style: FontStyle.titleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: PrimaryTheme.backgroundColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              //todo AQUI PONDRÉ LAS RUTINAS QUE SE CREEN
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sin rutinas'),
                ],
              ), 
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _mostrarBottomSheet(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline_sharp, color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Crear rutina",style: FontStyle.buttonTextStyle,),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(PrimaryTheme.secundaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0), // Hacerlo cuadrado
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _mostrarBottomSheet(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  String nombreRutina = ''; 

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: height * 0.6, 
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Nombre de la rutina:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                nombreRutina = value;
              },
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre de la rutina',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectExercisesScreen())
            );
              },
              child: const Text('Añadir ejercicios'),
            ),
          ],
        ),
      );
    },
  );
}
