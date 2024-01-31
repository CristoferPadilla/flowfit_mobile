import 'package:flutter/material.dart';

class PrimaryTheme {
  // Colores primarios de la app
  // ignore: use_full_hex_values_for_flutter_colors
  static const Color primaryColor = Color.fromARGB(237, 22, 135, 26); 
  static const Color secundaryColor = Color.fromARGB(158, 210, 151, 0); 
//Background
  static const Color backgroundColor = Color(0xFF070611); 
  
  //Theme
  static final ThemeData DarkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: secundaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary:secundaryColor,
      onError: Colors.red,
      primaryContainer: Colors.amber,
      tertiaryContainer: Colors.green,
    ));
}
