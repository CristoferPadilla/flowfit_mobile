import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class RoutineOptionContainer extends StatelessWidget {
  final Widget screen;
  final String title;
  final String description;
  final IconData icon;

  const RoutineOptionContainer({super.key, required this.screen, required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color:PrimaryTheme.secundaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ],
              ),
              Text(description,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white), )
            ]
            ),
        ),
      ),
    );
  }
}