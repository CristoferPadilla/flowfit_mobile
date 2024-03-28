import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';

class ColumnData extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String number;
  const ColumnData({
    Key? key,
    required this.title,
    required this.number,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 45,
            color: PrimaryTheme.secundaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              number,
              style: FontStyle.titleTextStyle.copyWith(fontSize: 25),
            ),
          ),
          Text(
            title,
            style: FontStyle.cardTextStyle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}