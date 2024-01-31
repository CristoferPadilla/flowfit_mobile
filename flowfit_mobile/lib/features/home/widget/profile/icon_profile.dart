import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class IconProfile extends StatelessWidget {
  const IconProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child:  const Icon(
        Icons.person,
        color: PrimaryTheme.backgroundColor,
        size: 30,
      )
    );
  }
}
