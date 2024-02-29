import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
class CustomeCategoryContainer extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color? color;
  const CustomeCategoryContainer({super.key, this.icon, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 5,),
            Text(title, style: FontStyle.cardTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)
          ],
        ),
      
      ),
    );
  }
}
