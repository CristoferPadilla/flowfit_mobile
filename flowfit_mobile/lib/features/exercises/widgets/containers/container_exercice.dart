import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';

class ContainerExercice extends StatelessWidget {
  final String name;
  final String gifUrl;
  final String? bodyPart;
  final String? instructions;
  final bool isSelected;
  final VoidCallback onTap; // Agregar el callback onTap

  const ContainerExercice({
    Key? key,
    required this.name,
    required this.gifUrl,
    this.bodyPart,
    this.instructions,
    required this.isSelected,
    required this.onTap, // Agregar onTap como argumento del constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap, // Llamar onTap cuando se toque el widget
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(gifUrl),
                ),
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
                      name,
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
            Container(
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
          ],
        ),
      ),
    );
  }
}
