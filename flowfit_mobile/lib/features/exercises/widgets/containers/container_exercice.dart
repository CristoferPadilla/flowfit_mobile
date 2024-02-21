import 'package:flowfit_mobile/features/exercises/screens/description_exercise_screen.dart';
import 'package:flutter/material.dart';

class ContainerExercice extends StatelessWidget {
  final String name;
  final String gifUrl;
  final String? bodyPart;
  final String? instruction;
  const ContainerExercice({super.key, required this.name, required this.gifUrl, this.bodyPart, this.instruction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  DescriptionExerciseScreen(name: name, gifUrl: gifUrl,)
          ),);  },
        child: Container(
          width: double.infinity,
          height: 100,
          
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            image:  DecorationImage(
              image: NetworkImage(gifUrl), ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black, ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}