import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;

  const CustomSlider({
    Key? key,
    required this.value,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentValue = 1.0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd!(value);
            }
          },
          min: 1,
          max: 3,
          divisions: 2,
          label: _currentValue.round().toString(),
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
