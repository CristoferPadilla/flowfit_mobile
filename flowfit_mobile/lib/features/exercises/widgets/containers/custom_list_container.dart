import 'package:flowfit_mobile/features/exercises/screens/description_exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flutter/widgets.dart';

class CustomListContainer extends StatelessWidget {
  final String gifUrl;
  final String instruction;
  final String bodyPart;
  final String name;
  const CustomListContainer({
    super.key, required this.gifUrl, required this.name, required this.instruction, required this.bodyPart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  DescriptionExerciseScreen(name: name, gifUrl: gifUrl, instructions: instruction, bodyPart: bodyPart,)
          ),);  
          },
          child: Row(
            children: [
              Container(
                height:100,
                width: 100,
                decoration: BoxDecoration(
                             image:  DecorationImage(
          image: NetworkImage(gifUrl), ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:100,
                  width: 250,
                  decoration: const BoxDecoration(
                    // color: Colors.blue
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(name,style: FontStyle.titleTextStyle.copyWith(fontSize: 15),),
                      Text('12x5',style: FontStyle.descriptionTextStyle.copyWith(fontSize: 15)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider()

      ],
    );
  }
}


