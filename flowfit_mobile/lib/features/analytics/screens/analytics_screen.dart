import 'package:flowfit_mobile/features/analytics/widgets/calendary/calendary_screen.dart';
import 'package:flowfit_mobile/features/analytics/widgets/card/custome_container_card.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        height:0.18,
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
                            const Expanded(
                              child: CalendarDays(),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '1 ',
                                  style: FontStyle.titleTextStyle
                                      .copyWith(fontSize: 20),
                                ),
                                Text(
                                  'Día en racha',
                                  style: FontStyle.cardTextStyle
                                      .copyWith(fontSize: 15),
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
                      const CustomContainerCard(
                        height: 0.10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Estatura: 160 cm', 
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Peso: 70 kg', 
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),)     ,   
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
                  const CustomContainerCard(
                    height:  0.10,
                    child: Center(
                      child: Text(
                        'IMC: 24.22', 
                        style: TextStyle(fontSize: 18),
                      ),
                    ),)    
                    ]
                    ),
              ),
            )));
  }
}

class ColumnData extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String number;
  const ColumnData({
    super.key,
    required this.title,
    required this.number,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(
          icon,
          size: 45,
          color: PrimaryTheme.secundaryColor,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            number,
            style: FontStyle.titleTextStyle.copyWith(fontSize: 25),
          ),
        ),
        Text(
          title,
          style: FontStyle.cardTextStyle.copyWith(fontSize: 15),
        ),
      ]),
    );
  }
}
