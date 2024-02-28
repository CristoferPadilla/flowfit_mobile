
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class IconProfileStack extends StatelessWidget {
  final bool isEdit;

  const IconProfileStack({
    super.key,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 128, 128, 128),
                border: Border.fromBorderSide(
                    BorderSide(color: PrimaryTheme.secundaryColor, width: 3)),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile_example.jpg',
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
              )),
        ),
      ),
      if (isEdit == true)
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 100),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: PrimaryTheme.secundaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
    ]);
  }
}
