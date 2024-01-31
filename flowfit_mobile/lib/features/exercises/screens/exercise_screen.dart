import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PrimaryTheme.backgroundColor,
      bottomNavigationBar: NavBar(),

    );
  }
}