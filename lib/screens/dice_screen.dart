import 'package:flutter/material.dart';
import 'dart:math';

class DiceScreen extends StatelessWidget {
  const DiceScreen({super.key});

  void _rollDice(BuildContext context, int faces) {
    final result = Random().nextInt(faces) + 1;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Rolou um D$faces'),
        content: Text(
          '$result',
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rolar Dados')),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [20, 12, 10, 8, 6, 4].map((faces) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
                shape: const CircleBorder(),
              ),
              onPressed: () => _rollDice(context, faces),
              child: Text('D$faces', style: const TextStyle(fontSize: 20)),
            );
          }).toList(),
        ),
      ),
    );
  }
}