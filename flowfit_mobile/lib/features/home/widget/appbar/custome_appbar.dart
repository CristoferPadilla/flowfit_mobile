import 'package:flutter/material.dart';

class CustomeAppbar extends StatelessWidget {
  const CustomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child:  const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
          children: [
            Text(
              'Febrero',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              '¡Hoy es un buen día para entrenar!',
              style: TextStyle(color: Colors.white),
            ),
          ],
           ),
        ],
      ),
    );
  }
}
