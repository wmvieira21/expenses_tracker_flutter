import 'package:expenses_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorsScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorsScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorsScheme.onPrimaryContainer,
          foregroundColor: kColorsScheme.onPrimary,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorsScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorsScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: kColorsScheme.onSecondaryContainer,
                  fontSize: 18),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
