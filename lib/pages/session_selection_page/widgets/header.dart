import 'package:flutter/material.dart';

Widget buildHeader(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Colors.tealAccent,
      shadows: [
        Shadow(
          offset: Offset(2, 2),
          blurRadius: 5,
          color: Colors.black45,
        )
      ],
    ),
  );
}
