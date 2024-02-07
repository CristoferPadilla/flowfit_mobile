import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class SectionButtons extends StatelessWidget {
  final bool isBackButtonVisible;
  final bool isFrontButtonVisible;
  final Widget screen;
  const SectionButtons(
      {Key? key, required this.isBackButtonVisible, required this.screen, required this.isFrontButtonVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isBackButtonVisible == true)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                height: 70,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: PrimaryTheme.secundaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back_sharp,
                      size: 25,
                      color: Colors.white,
                    ),
                    Text('Regresar',
                        style:
                            FontStyle.buttonTextStyle.copyWith(fontSize: 15)),
                  ],
                ),
              ),
            ),
                      if (isFrontButtonVisible == true)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  screen,
                ),
              );
            },
            child: Container(
              width: 150,
              height: 70,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: PrimaryTheme.secundaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_forward_sharp,
                    size: 25,
                    color: Colors.white,
                  ),
                  Text('Siguiente',
                      style: FontStyle.buttonTextStyle.copyWith(fontSize: 15)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
