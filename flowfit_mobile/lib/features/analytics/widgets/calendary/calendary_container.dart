import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
class CalendaryContainer extends StatelessWidget {
  final String day;
  final String assignedRoutine;
  const CalendaryContainer({super.key, required this.day, required this.assignedRoutine, MaterialColor? color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 1), 
          ),
        ],
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: PrimaryTheme.secundaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            assignedRoutine,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}