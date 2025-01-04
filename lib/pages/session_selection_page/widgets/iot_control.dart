import 'package:flutter/material.dart';

Widget buildIotControls() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.tealAccent, size: 30),
            SizedBox(height: 5),
            Text('Lights', style: TextStyle(color: Colors.white)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.wb_sunny, color: Colors.tealAccent, size: 30),
            SizedBox(height: 5),
            Text('Fans', style: TextStyle(color: Colors.white)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.ac_unit, color: Colors.tealAccent, size: 30),
            SizedBox(height: 5),
            Text('AC', style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    ),
  );
}
