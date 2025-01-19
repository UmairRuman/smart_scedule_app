import 'package:flutter/material.dart';

Widget buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.tealAccent,
    ),
  );
}
