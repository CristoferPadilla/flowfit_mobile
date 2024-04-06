import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';

class CustomFieldData extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String name;
  final Widget? screen; // Cambiado a Widget?
  final void Function()? onTap;

  const CustomFieldData({
    Key? key,
    required this.title,
    required this.name,
    this.screen, // Cambiado a Widget?
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 1,
          color: PrimaryTheme.secundaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: FontStyle.descriptionTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                if (icon != null) // Asegúrate de que icon no sea nulo
                  Icon(icon, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
