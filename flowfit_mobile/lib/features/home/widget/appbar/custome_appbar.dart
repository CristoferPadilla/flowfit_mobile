import 'package:flutter/material.dart';

class CustomeAppbar extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomeAppbar({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    final String currentMonth = months[DateTime.now().month - 1];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
          children: [
            Text(
              currentMonth,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white),
            ),
          ],
           ),
        ],
      ),
    );
  }
}
