import 'package:flowfit_mobile/features/exercises/screens/body_part_screen.dart';
import 'package:flowfit_mobile/features/exercises/screens/select_exercise_screen.dart';
import 'package:flowfit_mobile/features/exercises/widgets/containers/routine_option_container.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile.dart';
import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomeAppbar(title: 'Febrero',subtitle: '¡Hoy es un gran día para entrenar',),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: IconProfile(),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
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
                'Elige los ejercicios y crea tu propia rutina',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RoutineOptionContainer(
              icon:Icons.add_circle_outline_sharp,
              title: 'Rutina personalizada',
              description: 'Crea tu propia rutina de ejercicios',
              screen: BodyPartScreen(),
            ),
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
              icon: Icons.slow_motion_video_outlined,
              title: 'Empezar rutina',
              description: '',
              screen: SelectExercisesScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
