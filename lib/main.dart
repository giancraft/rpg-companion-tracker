import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'controllers/game_controller.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameController(),
      child: const RPGCombatApp(),
    ),
  );
}

class RPGCombatApp extends StatefulWidget {
  const RPGCombatApp({super.key});

  @override
  State<RPGCombatApp> createState() => _RPGCombatAppState();
}

class _RPGCombatAppState extends State<RPGCombatApp> {
  @override
  void initState() {
    super.initState();
    _removeSplash();
  }

  void _removeSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Combat Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        textTheme: GoogleFonts.cinzelTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
