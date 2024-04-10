import 'dart:convert';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeekDays extends StatefulWidget {
  const WeekDays({Key? key});

  @override
  State<WeekDays> createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDays> {
  DateTime? _endDate;
  DateTime? _startDate;
  List<DateTime> gymDays = [];

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? id = prefs.getString('id');

    try {
      final response = await http.get(
        Uri.parse('https://api-zydf.onrender.com/members/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String startDateString = responseData['registration_date'];
        final int startDateMillisecondsSinceEpoch = int.parse(startDateString);
        final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillisecondsSinceEpoch);

        final String endDateString = responseData['end_date'];
        final int endDateMillisecondsSinceEpoch = int.parse(endDateString);
        final DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDateMillisecondsSinceEpoch);

        setState(() {
          _startDate = startDate;
          _endDate = endDate;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }
  

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _endDate != null
        ? CalendarDays(endDate: _endDate!, gymDays: gymDays.map((day) => DateTime(day.year, day.month, day.day)).toList(), startDate: _startDate!,)
        : CircularProgressIndicator(); 
  }
}

class CalendarDays extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> gymDays;

  CalendarDays({
    required this.startDate,
    required this.endDate,
    required this.gymDays,
    Key? key,
  }) : super(key: key);

  @override
  _CalendarDaysState createState() => _CalendarDaysState();
}

class _CalendarDaysState extends State<CalendarDays> {
  late int _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.startDate.month;
  }

void _updateMonthName(DateTime startDate, DateTime endDate) {
  setState(() {
    _currentMonth = startDate.month;
    if (startDate.month != endDate.month) {
      _currentMonth = endDate.month;
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Mes: ${getMonthName(_currentMonth)}',
            style: FontStyle.titleTextStyle.copyWith(color: Colors.grey, fontSize: 17),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _calculateDaysToShow(widget.startDate, widget.endDate),
                (index) {
                  final day = widget.startDate.add(Duration(days: index));
                  final formattedDate = day.day.toString().padLeft(2, '0');

                  // Detener el calendario si el día es posterior a la fecha de finalización
                  if (day.isAfter(widget.endDate)) {
                    return SizedBox(); // No mostrar más días después de la fecha de finalización
                  }

                  final nextDay = widget.startDate.add(Duration(days: index + 1));
                  _updateMonthName(day, nextDay); // Llamar al método para actualizar el nombre del mes

                  final isEndDate = day.day == widget.endDate.day && day.month == widget.endDate.month;
                  final isStartDate = day.day == widget.startDate.day && day.month == widget.startDate.month;
                  final isGymDay = widget.gymDays.any((gymDay) =>
                      gymDay.year == day.year && gymDay.month == day.month && gymDay.day == day.day);

                  // Color del día
                  Color dayColor;
                  if (isEndDate) {
                    dayColor = Colors.red;
                  } else if (isStartDate) {
                    dayColor = Colors.green;
                  } else if (day.month == widget.startDate.month) {
                    // Si el día está en el mes de inicio, usar el color del gimnasio o blanco
                    dayColor = isGymDay ? PrimaryTheme.secundaryColor : const Color.fromARGB(255, 142, 142, 142);
                  } else if (day.month == widget.endDate.month) {
                    // Si el día está en el mes de fin, usar rojo
                    dayColor = Colors.grey;
                  } else {
                    // Si el día está en otro mes, usar gris
                    dayColor = Colors.grey;
                  }

                  return Container(
                    width: 40,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: dayColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayOfWeek(day),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _calculateDaysToShow(DateTime startDate, DateTime endDate) {
    if (startDate.year == endDate.year && startDate.month == endDate.month) {
      // Si startDate y endDate están en el mismo mes
      return endDate.day - startDate.day + 1;
    } else {
      // Si startDate y endDate están en meses diferentes
      final daysInStartMonth = DateTime(startDate.year, startDate.month + 1, 0).day;
      final daysInBetween = daysInStartMonth - startDate.day + 1; // Días restantes en el mes de inicio
      final daysInEndMonth = endDate.day; // Días en el mes de fin
      return daysInBetween + daysInEndMonth; // Total de días a mostrar
    }
  }

  String _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Lun';
      case DateTime.tuesday:
        return 'Mar';
      case DateTime.wednesday:
        return 'Mié';
      case DateTime.thursday:
        return 'Jue';
      case DateTime.friday:
        return 'Vie';
      case DateTime.saturday:
        return 'Sáb';
      case DateTime.sunday:
        return 'Dom';
      default:
        return '';
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
      default:
        return '';
    }
  }
}
