import 'package:expenses_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorsScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

var kColorsSchemeDark = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 5, 99, 125), brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: kColorsSchemeDark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorsSchemeDark.onPrimaryContainer,
                foregroundColor: kColorsSchemeDark.onPrimary),
          ),
          cardTheme: CardTheme().copyWith(
            color: kColorsSchemeDark.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          )),
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
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
  // });
}
