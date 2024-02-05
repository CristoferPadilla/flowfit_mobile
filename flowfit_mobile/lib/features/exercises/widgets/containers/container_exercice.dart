import 'package:flutter/material.dart';

class ContainerExercice extends StatelessWidget {
  final String bodyPart;
  const ContainerExercice({super.key, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child:  Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              Text(
                bodyPart,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ],
      ),
    );
  }
}