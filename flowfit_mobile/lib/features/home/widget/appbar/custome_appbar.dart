import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class CustomeAppbar extends StatelessWidget {
  const CustomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: PrimaryTheme.secundaryColor.withOpacity(0.9),
      ),
      child:  const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
          children: [
            Text(
              'Enero',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              '¡Hoy es un buen día para entrenar!',
              style: TextStyle(color: PrimaryTheme.backgroundColor),
            ),
          ],
           ),
        ],
      ),
    );
  }
}
