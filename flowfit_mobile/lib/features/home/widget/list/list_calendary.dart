import 'package:flowfit_mobile/features/home/widget/calendary/calendary_container.dart';
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
        itemCount: 30,
        itemBuilder: (context, index) {
          final dayOfWeek = index % 7;
          final day = _getDayOfWeek(dayOfWeek);
          final date = (index + 1).toString();
          final isToday = _isToday(dayOfWeek);

          return Transform.scale(
            scale: isToday ? 1.2 : 1.0,
            child: CalendaryContainer(
              day: day,
              date: date,
              color: isToday ? Colors.red : null,
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
}