/**
 * Expense Tracker App Documentation
 *
 * This code is the entry point for an Expense Tracker application built using the Flutter framework.
 * The app provides a simple user interface for tracking expenses and is thematically styled with
 * light and dark color schemes.
 *
 * Table of Contents:
 * 1. Color Schemes
 * 2. Main Function
 *
 * 1. Color Schemes:
 *
 * - `kColorScheme`: A light color scheme for the app.
 * - `kDarkColorScheme`: A dark color scheme for the app.
 *
 * 2. Main Function:
 *
 * The `main` function initializes and runs the Flutter application. It configures the MaterialApp
 * widget with light and dark themes, specifying color schemes and styling for various UI elements.
 * The app's home screen is set to display the `Expenses` widget.
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom widget
import 'package:app/widgets/expenses.dart';

// Define a light color scheme for the app
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

// Define a dark color scheme for the app
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

// Entry point of the application
void main() {
  runApp(
    MaterialApp(
      // Configure dark theme for the app
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      // Configure light theme for the app
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      // Set the default home screen to the Expenses widget
      home: const Expenses(),
    ),
  );
}