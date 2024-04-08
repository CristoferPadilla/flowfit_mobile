import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowfit_mobile/features/analytics/widgets/column/custome_column.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/features/analytics/widgets/card/custome_container_card.dart';
import 'package:flowfit_mobile/features/analytics/widgets/calendary/calendary_screen.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late double _height = 0.0;
  late double _weight = 0.0;
  late double _bmi = 0.0;
  late DateTime _endDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? id = prefs.getString('id');
    try {
      final response = await http.get(
        Uri.parse('https://api-zydf.onrender.com/members'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        if (responseData.isNotEmpty) {
          for (var userData in responseData) {
            if (userData['id'].toString() == id) {
              setState(() {
                _height = double.parse(userData['height'].toString());
                _weight = double.parse(userData['weight'].toString());
                _bmi = double.parse(userData['body_fat_percentage'].toString());
                _endDate = DateTime.parse(userData['end_date'].toString());
                _isLoading = false;
              });
              break; 
            }
          }
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'INFORME',
                          style: FontStyle.titleTextStyle.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const CustomContainerCard(
                        height: 0.18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColumnData(
                              title: 'Ejercicios',
                              icon: Icons.fitness_center_rounded,
                              number: '4',
                            ),
                            ColumnData(
                              title: 'Kcal',
                              icon: Icons.local_fire_department_rounded,
                              number: '11',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Historial',
                          style: FontStyle.titleTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CustomContainerCard(
                        height: 0.18,
                        child: Column(
                          children: [
                            Expanded(
                              child: CalendarDays(endDate: _endDate),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '1 ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Día en racha',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Datos personales',
                          style: FontStyle.titleTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CustomContainerCard(
                        height: 0.10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Estatura: $_height m',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Peso: $_weight kg',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Índice de masa corporal',
                          style: FontStyle.titleTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CustomContainerCard(
                        height: 0.10,
                        child: Center(
                          child: Text(
                            'IMC: $_bmi',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
