import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/categories.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 245, 79, 117),
  ),
  textTheme: GoogleFonts.manropeTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home: const CategoriesScreen() 
    );
  }
}