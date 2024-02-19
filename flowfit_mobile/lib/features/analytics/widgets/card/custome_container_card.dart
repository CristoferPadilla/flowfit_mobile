import 'package:flutter/material.dart';

class CustomContainerCard extends StatelessWidget {
  final Widget child;
  final double height;
  const CustomContainerCard({
    super.key, required this.child, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final height2 = MediaQuery.of(context).size.height; 
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: height2 * height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child:child
      ));
  }
}