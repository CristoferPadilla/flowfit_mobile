import 'package:flutter/material.dart';


class CustomeTextTitle extends StatelessWidget {
  final String title;
  final double size;
  const CustomeTextTitle({
    super.key, required this.title, required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(
      title,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}