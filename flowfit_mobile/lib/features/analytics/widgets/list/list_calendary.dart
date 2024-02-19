import 'package:flowfit_mobile/features/exercises/screens/body_part_screen.dart';
import 'package:flowfit_mobile/features/exercises/screens/select_exercise_screen.dart';
import 'package:flowfit_mobile/features/analytics/widgets/calendary/calendary_container.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class ListCalendary extends StatelessWidget {
  const ListCalendary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 29,
        itemBuilder: (context, index) {
          final dayOfWeek = index % 7;
          final day = _getDayOfWeek(dayOfWeek);
          final date = (index + 1).toString();
          final isToday = _isToday(dayOfWeek);

          return GestureDetector(
            onTap: () => _showDialog(context, day),
            child: Transform.scale(
              scale: isToday ? 1.2 : 1.0,
              child: CalendaryContainer(
                day: day,
                date: date,
                color: isToday ? Colors.red : null,
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

  void _showDialog(BuildContext context, String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,  
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(day, style: FontStyle.titleTextStyle,),
                  Text('Asigna una rutina para hoy', style: FontStyle.descriptionTextStyle.copyWith(color: Colors.black)),
                  const SizedBox(height: 40),
                  const CustomeButton(titleButton: 'Establecer rutina', screen: BodyPartScreen(),),
                  const CustomeButton(titleButton: 'Rutina personalizada', screen: SelectExercisesScreen(),)],
              ),
            ),
          ),

        );
      },
    );
  }
}

class CustomeButton extends StatelessWidget {
  final String titleButton ;
  final Widget screen;

  const CustomeButton({
    super.key, required this.titleButton, required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen)
            );
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PrimaryTheme.secundaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Center(child: Text(titleButton, style: FontStyle.buttonTextStyle,)),
        ),
      )
                );
  }
}
