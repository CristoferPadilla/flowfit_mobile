import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({
    Key? key,
    required this.startDate,
    required this.validUntil,
  }) : super(key: key);

  final String startDate;
  final String validUntil;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: PrimaryTheme.secundaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tu Membresía',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Inicio: $startDate',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                                color: Colors.white

              ),),
            const SizedBox(height: 5),
            Text(
              'Válido hasta: $validUntil',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                                color: Colors.white

                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
