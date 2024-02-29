import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';

class CustomFielDataNoScren extends StatelessWidget {
  final String title;
  final String name;

  const CustomFielDataNoScren({
    Key? key,
    required this.title,
     required this.name, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: FontStyle.titleTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: FontStyle.descriptionTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
