import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/game_controller.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameController(),
      child: const RPGCombatApp(),
    ),
  );
}

class RPGCombatApp extends StatelessWidget {
  const RPGCombatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epic RPG Combat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        textTheme: GoogleFonts.cinzelTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomeScreen(), // Nossa nova Splash/Home
    );
  }
}