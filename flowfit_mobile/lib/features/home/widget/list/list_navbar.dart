import 'package:flowfit_mobile/features/analytics/screens/analytics_screen.dart';
import 'package:flowfit_mobile/features/exercises/screens/exercise_screen.dart';
import 'package:flowfit_mobile/features/home/screens/home_screen.dart';
import 'package:flowfit_mobile/features/membership/screens/memberships_screen.dart';
import 'package:flowfit_mobile/features/profile/screens/profile_screen.dart';
// import 'package:flowfit_mobile/features/shop/screen/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';


  int selectedindex = 0;

final List<Widget> navScreens = <Widget>[
  // ShowCaseWidget(
  //     autoPlay: true,
  //     autoPlayDelay: const Duration(milliseconds: 5000),
  //     scrollDuration: const Duration(seconds: 3),
  //     builder: Builder(builder: ((context) => const HomeScreen()))),
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const ExercisesScreen()))),
  // ShowCaseWidget(
  //     autoPlay: true,
  //     autoPlayDelay: const Duration(milliseconds: 5000),
  //     scrollDuration: const Duration(seconds: 3),
  //     builder: Builder(builder: ((context) => const ShopScreen()))),
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const MembershipScreen()))),
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const AnalyticsScreen()))),
  ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(milliseconds: 5000),
      scrollDuration: const Duration(seconds: 3),
      builder: Builder(builder: ((context) => const ProfileScreen()))),

];
