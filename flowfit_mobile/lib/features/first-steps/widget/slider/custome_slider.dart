import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double>? onChanged;

  const CustomSlider({super.key, 
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 1,
          max: 3,
          divisions: 2,
          label: value.round().toString(),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Bajo'),
            Text('Medio'),
            Text('Avanzado'),
          ],
        ),
      ],
    );
  }
}
