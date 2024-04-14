import 'package:flowfit_mobile/features/analytics/widgets/list/list_calendary.dart';
import 'package:flowfit_mobile/features/shop/widgets/buttons/custom_button.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flutter/material.dart';

class DescriptionExerciseScreen extends StatelessWidget {
  final String name;
  final String gifUrl;
  final String bodyPart;
  final String instructions;

  const DescriptionExerciseScreen({
    Key? key,
    required this.name,
    required this.gifUrl,
    required this.bodyPart,
    required this.instructions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
        title: Text(name),
        // Agregar un botón de regreso en el AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.5,
                child: Stack(
                  children: [
                    Image.network(
                      gifUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    // Positioned(
                    //   bottom: 10,
                    //   right: 10,
                    //   child: FloatingActionButton(
                    //     onPressed: () {},
                    //     child: const Icon(Icons.play_arrow),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.fitness_center, color: Colors.blue),
          const SizedBox(width: 2,),
          Text(
            name,
            maxLines: 1, 
            overflow: TextOverflow.fade, 
            style: FontStyle.cardTextStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Text(
        'Se ejercita: $bodyPart',
        style: const TextStyle(fontSize: 16),
      ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Instrucciones",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      instructions,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
