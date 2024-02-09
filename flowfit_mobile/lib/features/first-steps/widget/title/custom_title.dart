import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flutter/material.dart';
class CustomTitleSteps extends StatelessWidget {
  final String title;
  final String description;

  const CustomTitleSteps({
    super.key, required this.title, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            title,
            style: FontStyle.titleTextStyle.copyWith(
              color: PrimaryTheme.secundaryColor,
              fontSize: 50,
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            style: FontStyle.descriptionTextStyle,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
