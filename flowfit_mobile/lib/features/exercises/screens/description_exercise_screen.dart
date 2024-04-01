import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flutter/material.dart';

class DescriptionExerciseScreen extends StatelessWidget {
  final String name;
  final String gifUrl;
  final String? bodyPart;
  final String? instructions;

  const DescriptionExerciseScreen({
    Key? key,
    required this.name,
    required this.gifUrl,
    this.bodyPart,
    this.instructions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? formattedInstructions = instructions?.replaceAll(',', '\n');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: 'Aprende',
            subtitle: '¡Repasa y aprende con técnica!',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Placeholder(
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        gifUrl,
                      ),
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Text(
                      'Nombre del ejercicio:  ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Text(
                      'Área que se entrena:  ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bodyPart ?? 'No disponible',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Instrucciones',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(formattedInstructions ?? "No disponible"),
                  ],
                ),
              ),
              SectionButtons(
                isBackButtonVisible: true,
                isFrontButtonVisible: false,
                screen: DescriptionExerciseScreen(
                  name: name,
                  gifUrl: gifUrl,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
