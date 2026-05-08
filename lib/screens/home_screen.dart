import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'setup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield, size: 120, color: Colors.orangeAccent),
            const SizedBox(height: 20),
            Text(
              'RPG Combat Tracker',
              style: GoogleFonts.cinzel(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Iniciar Novo Combate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SetupScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}