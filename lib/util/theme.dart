import 'package:flutter/material.dart';

final myTheme = ThemeData.dark().copyWith(
  // Dark theme background colors
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: const Color(0xFF1F1F1F),

  // Hint color
  hintColor: Colors.tealAccent,

  // Customizing text styles
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Colors.tealAccent, // Large text color
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      color: Colors.white, // Small text inside buttons
      fontSize: 16,
    ),
  ),

  // Customizing ElevatedButton globally
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black, // Text inside buttons
      backgroundColor: Colors.tealAccent, // Button background
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),

  // Customizing IconTheme
  iconTheme: IconThemeData(
    color: Colors.tealAccent, // Icon color
  ),
);
