import 'package:flowfit_mobile/features/login/screen/login_screen.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: PrimaryTheme.DarkTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen()
    );
  }
}
