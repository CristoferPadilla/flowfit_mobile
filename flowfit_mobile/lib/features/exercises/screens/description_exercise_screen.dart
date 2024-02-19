import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flutter/material.dart';

class DescriptionExerciseScreen extends StatelessWidget {
  const DescriptionExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: 'Aprende',
            subtitle: '¡Repasa y aprende con técnica!',
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 200, 
                child: Placeholder(
                  child: Image(image: AssetImage("assets/example.gif")),
                )
              ),
            ),
            SizedBox(height: 20), 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Nombre del ejercicio:  ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Curl de bíceps',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Área que se entrena:  ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Brazo',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), 

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Instrucciones',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text('De pie, sostén una mancuerna en cada mano con los brazos extendidos hacia abajo y las palmas mirando hacia adelante.\nMantén los codos pegados a los costados del cuerpo. \nFlexiona los brazos, levantando las mancuernas hacia los hombros.\nHaz una pausa en la posición superior, contrayendo los músculos del bíceps.\nBaja lentamente las mancuernas de nuevo a la posición inicial, manteniendo el control. \nRepite durante el número deseado de repeticiones.'),
                ],
              ),
            ),
            Spacer(),
            SectionButtons(isBackButtonVisible: true,isFrontButtonVisible: false, screen: DescriptionExerciseScreen(),)

          ],
        ),
      ),
    );
  }
}
