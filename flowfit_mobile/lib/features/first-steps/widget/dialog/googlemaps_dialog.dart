import 'package:flutter/material.dart';


class GoogleMapsDialog extends StatelessWidget {
  const GoogleMapsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
        ),
        ),
    );
  }
}