import 'dart:convert';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
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
  bool _isLoading = true;

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

        final String endDateString = responseData['end_date'];
        final int endDateMillisecondsSinceEpoch = int.parse(endDateString);
        final DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDateMillisecondsSinceEpoch);

        setState(() {
          _endDate = endDate;
          _isLoading = false;
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
    return _endDate != null ? CalendarDays(endDate: _endDate!) : CircularProgressIndicator(); // Mostrar un indicador de carga si _endDate es nulo
  }
}

class CalendarDays extends StatelessWidget {
  final DateTime endDate;
  final int daysInMonth = DateTime.daysPerWeek * 5;

  CalendarDays({required this.endDate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final daysUntilEndOfMonth = endDate.day - currentDate.day;
    final daysToShow = daysUntilEndOfMonth > daysInMonth ? daysInMonth : daysUntilEndOfMonth +1;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Mes: ${getMonthName(endDate.month)}',style: FontStyle.titleTextStyle.copyWith(color: Colors.grey,fontSize: 17),),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                daysToShow,
                (index) {
                  final day = currentDate.add(Duration(days: index));
                  final formattedDate = day.day.toString().padLeft(2, '0');

                  final isEndDate = day.day == endDate.day;

                  return Container(
                    width: 40,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isEndDate ? Colors.red : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayOfWeek(day),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isEndDate ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 18,
                            color: isEndDate ? Colors.white : Colors.black,
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
