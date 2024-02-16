import 'package:flowfit_mobile/features/exercises/screens/select_exercise_screen.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';


class ContainerExerciseBodyParts extends StatelessWidget {
  final String bodypart;
  final String subtitle;
  const ContainerExerciseBodyParts({
    super.key, required this.bodypart, required this.subtitle, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectExercisesScreen()),
            );
          
          },
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: PrimaryTheme.backgroundColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings_accessibility_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(width: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        bodypart,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white, ),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white, ),
                    ),
                  ],
                ),
              ),
                
            ],),
          ),
        ),
    ));}}