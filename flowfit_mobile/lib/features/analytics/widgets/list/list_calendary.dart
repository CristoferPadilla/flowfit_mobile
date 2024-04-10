import 'dart:convert';

import 'package:flowfit_mobile/features/analytics/widgets/calendary/calendary_container.dart';
import 'package:flowfit_mobile/features/exercises/screens/create_routine_screen.dart';
import 'package:flowfit_mobile/features/exercises/screens/save_routine_screen.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


extension CastExtension on Map<dynamic, dynamic> {
  Map<String, String> castToStringMap() {
    return Map<String, String>.from(this).map((key, value) => MapEntry(key as String, value as String));
  }
}

class ListCalendary extends StatefulWidget {
  const ListCalendary({Key? key}) : super(key: key);

  @override
  _ListCalendaryState createState() => _ListCalendaryState();
}

class _ListCalendaryState extends State<ListCalendary> {
  final Map<String, String> assignedRoutines = {};
  String? selectedRoutineName;

  @override
  void initState() {
    super.initState();
    _loadAssignedRoutines();
  }

  Future<void> _loadAssignedRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedData = prefs.get('assignedRoutines');

    if (loadedData != null && loadedData is Map<dynamic, dynamic>) {
      setState(() {
        assignedRoutines.addAll(loadedData.castToStringMap());
      });
    } else {
      print('No assigned routines found in SharedPreferences.');
    }
  }

  Future<void> _saveAssignedRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('assignedRoutines', jsonEncode(assignedRoutines));
  }

  void updateSelectedRoutine(String selectedRoutineName) {
    setState(() {
      this.selectedRoutineName = selectedRoutineName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final dayOfWeek = index % 7;
          final day = _getDayOfWeek(dayOfWeek);
          final isToday = _isToday(dayOfWeek);

          return GestureDetector(
            onTap: () => _showDialog(context, day, (selectedRoutineName) {
              updateSelectedRoutine(selectedRoutineName);
            }),
            child: Transform.scale(
              scale: isToday ? 1.2 : 1.0,
              child: CalendaryContainer(
                day: day,
                assignedRoutine: assignedRoutines[day] ?? '',
                color: isToday ? Colors.red : null, // Cambia el color a rojo si es hoy
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDayOfWeek(int dayOfWeek) {
    switch (dayOfWeek) {
      case 0:
        return 'Lun';
      case 1:
        return 'Mar';
      case 2:
        return 'Mié';
      case 3:
        return 'Jue';
      case 4:
        return 'Vie';
      case 5:
        return 'Sáb';
      case 6:
        return 'Dom';
      default:
        return '';
    }
  }

  bool _isToday(int dayOfWeek) {
    final now = DateTime.now();
    final currentDayOfWeek = now.weekday - 1;
    return dayOfWeek == currentDayOfWeek;
  }

  void _showDialog(BuildContext context, String day, Function(String) onRoutineSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final height = MediaQuery.of(context).size.height;
        final assignedRoutineName = assignedRoutines[day] ?? 'No hay rutina asignada para este día';

        return Dialog(
          child: Container(
            height: height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(day, style: FontStyle.titleTextStyle),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Rutina asignada: $assignedRoutineName',
                        style: FontStyle.descriptionTextStyle.copyWith(color: Colors.black)),
                  ),
                  const CustomeButton(titleButton: 'Crear rutina', screen: CreateRoutineScreen()),
                  CustomeButton(
                    titleButton: 'Establecer rutina',
                    screen: SavedRoutinesScreen(
                      onRoutineSelected: (selectedRoutineName) {
                        assignedRoutines[day] = selectedRoutineName;
                        _saveAssignedRoutines();
                        onRoutineSelected(selectedRoutineName);
                      },
                      isDialog: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomeButton extends StatelessWidget {
  final String titleButton;
  final Widget screen;

  const CustomeButton({
    required this.titleButton,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PrimaryTheme.secundaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: Text(titleButton, style: FontStyle.buttonTextStyle)),
        ),
      ),
    );
  }
}
