import 'package:flutter/material.dart';

class LevelContainers extends StatelessWidget {
  const LevelContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Column(
      children: [
        Text('Niveles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        Row(
          children: [
            ContainerLevel(level: 'Principiante', color: Colors.black,),
            ContainerLevel(level: 'Intermedio', color: Colors.black),
            ContainerLevel(level: 'Avanzado', color: Colors.black),
          ],
        ),
      ],
    );
  }
}

class ContainerLevel extends StatelessWidget {
  final String level;
  final Color color;
  const ContainerLevel({
    super.key, required this.level, required this.color, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Column(
          children: [
             const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 40,
              ),
            ),
            Text(
              level,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}