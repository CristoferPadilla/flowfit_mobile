import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const GNav(
      gap: 8,
      haptic: true,
      rippleColor: Colors.grey, 
      hoverColor: Colors.grey,
      activeColor: Colors.white,
      iconSize: 40,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      duration: Duration(milliseconds: 800),
      tabBackgroundColor: PrimaryTheme.secundaryColor,
      tabs: [
        GButton(
          icon: Icons.fitness_center,
          text: 'Entrenamiento',
        ),
        GButton(
          icon: Icons.home,
          text: 'Menú',
        ),
        GButton(
          icon: Icons.fastfood_sharp,
          text: 'Alimentación',
        ),
      ],
    );
  }
}
