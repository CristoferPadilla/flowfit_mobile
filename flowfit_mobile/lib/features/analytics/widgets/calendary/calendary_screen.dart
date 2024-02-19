
import 'package:flutter/material.dart';

class WeekDays extends StatelessWidget {
  final List<String> daysOfWeek = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

   WeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          daysOfWeek.length,
          (index) => Text(
            daysOfWeek[index],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CalendarDays extends StatelessWidget {
  final int daysInMonth = DateTime.daysPerWeek * 5;

  const CalendarDays({super.key}); 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        final currentDate = DateTime.now().add(Duration(days: index));
        final formattedDate = currentDate.day.toString().padLeft(2, '0');

        final isToday = currentDate.day == DateTime.now().day;

        return Container(
          width: 40,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isToday ? Theme.of(context).primaryColor : null, 
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getDayOfWeek(currentDate), 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isToday ?Colors.white: Colors.black
                   , 
                ),
              ),
              if (isToday) Icon(Icons.arrow_drop_down,
              color: isToday ?Colors.white: Colors.black, 
              ), 
              Text(
                formattedDate, // Número del día
                style: TextStyle(
                  fontSize: 18,
                  color: isToday ?Colors.white: Colors.black,
                   
                ),
              ),
            ],
          ),
        );
      },
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
}