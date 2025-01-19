import 'package:flutter/material.dart';

class StylishLineSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const StylishLineSlider({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StylishLineSlider> createState() => _StylishLineSliderState();
}

class _StylishLineSliderState extends State<StylishLineSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display Volume Value
        Text(
          '${(_currentValue * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 10, 79, 72),
          ),
        ),
        const SizedBox(height: 10),

        // Stylish Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.tealAccent,
            inactiveTrackColor: const Color.fromARGB(255, 1, 97, 87),
            trackHeight: 12.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            thumbColor: const Color.fromARGB(255, 4, 158, 148),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            overlayColor: Colors.teal.withOpacity(0.2),
          ),
          child: Slider(
            value: _currentValue,
            min: 0.0,
            max: 1.0,
            divisions: 20,
            label: '${(_currentValue * 100).toInt()}%',
            onChanged: (value) {
              setState(() {
                _currentValue = value;
                widget.onChanged(_currentValue);
              });
            },
          ),
        ),
      ],
    );
  }
}
