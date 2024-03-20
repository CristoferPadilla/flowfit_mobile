import 'package:flutter/material.dart';
import 'package:flowfit_mobile/features/exercises/screens/description_exercise_screen.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';

class ContainerExercice extends StatefulWidget {
  final String name;
  final String gifUrl;
  final String? bodyPart;
  final String? instructions;

  const ContainerExercice({
    Key? key,
    required this.name,
    required this.gifUrl,
    this.bodyPart,
    this.instructions,
  }) : super(key: key);

  @override
  _ContainerExerciceState createState() => _ContainerExerciceState();
}

class _ContainerExerciceState extends State<ContainerExercice> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionExerciseScreen(
                name: widget.name,
                gifUrl: widget.gifUrl,
                instructions: widget.instructions,
                bodyPart: widget.bodyPart,
              ),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                              image:  DecorationImage(
                image: NetworkImage(widget.gifUrl), ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected ? PrimaryTheme.secundaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: PrimaryTheme.secundaryColor,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
