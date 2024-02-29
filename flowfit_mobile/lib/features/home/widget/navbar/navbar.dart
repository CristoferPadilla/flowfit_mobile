import 'package:flowfit_mobile/features/home/widget/list/list_navbar.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: navScreens[selectedindex], 
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            haptic: false,
            rippleColor: Colors.grey,
            hoverColor: Colors.grey,
            activeColor: Colors.white,
            iconSize: 25,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            curve: Curves.easeInCubic,
            duration: const Duration(milliseconds: 400),
            tabBorderRadius: 50,
            tabBackgroundColor: PrimaryTheme.secundaryColor,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Menú',
              ),
              GButton(
                icon: Icons.fitness_center,
                text: 'Entrenamiento',
              ),
              GButton(
                icon: Icons.shopping_bag,
                text: 'Tienda',
              ),
              GButton(
                icon: Icons.analytics,
                text: 'Informe',
              ),
              GButton(
                icon: Icons.person,
                text: 'Perfil',
              ),
            ],
            selectedIndex: selectedindex,
            onTabChange: (index) {
              setState(() {
                selectedindex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
