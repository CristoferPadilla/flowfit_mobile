import 'package:flowfit_mobile/features/exercises/widgets/containers/level_container.dart';
import 'package:flowfit_mobile/features/exercises/widgets/containers/routine_option_container.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';
import 'package:flowfit_mobile/features/home/widget/profile/icon_profile.dart';
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
              CustomeAppbar(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: IconProfile(),
              )
            ]),
          ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            LevelContainers(),
            RoutineOptionContainer()
          ],
        )
      )
      );
  }
}
