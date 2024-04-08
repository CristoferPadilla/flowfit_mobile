import 'package:flowfit_mobile/features/exercises/screens/create_routine_screen.dart';
import 'package:flowfit_mobile/features/exercises/screens/save_routine_screen.dart';
import 'package:flowfit_mobile/features/exercises/widgets/containers/routine_option_container.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: 
              CustomeAppbar(title: '',subtitle: '¡Hoy es un gran día para entrenar',),
          
        ),
        backgroundColor: Colors.grey.shade100,
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Mis entrenamientos',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Has que tu entrenador elija tus ejercicios y crea tu propia rutina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RoutineOptionContainer(
                icon:Icons.add_circle_outline_sharp,
                title: 'Mis rutinas',
                description: 'Crea tu propia rutina de ejercicios',
                screen: CreateRoutineScreen(),
              ),
              //             Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'Rutinas establecidas',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'Selecciona la rutina acorde a tu nivel',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 12,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // RoutineOptionContainer(
              //   icon: Icons.search,
              //   title: 'Buscar rutina',
              //   description: "Inicia con la mejor rutina para tí",
              //   screen: BodyPartScreen(),
              // ),
                          Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Prueba tu rutina aquí',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Lleva un registro del tiempo de tus ejercicios',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RoutineOptionContainer(
                icon: Icons.play_circle_outline,
                title: 'Empezar rutina',
                description: '',
                screen: SavedRoutinesScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
