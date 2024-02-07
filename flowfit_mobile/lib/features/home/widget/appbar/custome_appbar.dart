import 'package:flutter/material.dart';

class CustomeAppbar extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomeAppbar({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
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
              title,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white),
            ),
          ],
           ),
        ],
      ),
    );
  }
}
