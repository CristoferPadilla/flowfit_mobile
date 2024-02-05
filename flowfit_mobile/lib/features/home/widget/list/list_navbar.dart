import 'package:flowfit_mobile/features/alimentation/screens/alimentation_screen.dart';
import 'package:flowfit_mobile/features/exercises/screens/exercise_screen.dart';
import 'package:flowfit_mobile/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';


  int selectedindex = 0;

final List<Widget> navScreens = <Widget>[
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const HomeScreen()))),
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const ExercisesScreen()))),
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const AlimentationScreen()))),

];
