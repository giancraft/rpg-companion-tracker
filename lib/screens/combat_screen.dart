import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../controllers/game_controller.dart';
import '../models/entity.dart';

class CombatScreen extends StatelessWidget {
  const CombatScreen({super.key});

  void _showAttackDialog(BuildContext context, Entity target, GameController controller) {
    int? damageRolled;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Atacando ${target.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (damageRolled == null) ...[
                    const Text('Escolha o dado de dano:', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [4, 6, 8, 10, 12, 20].map((faces) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            setState(() {
                              damageRolled = Random().nextInt(faces) + 1;
                            });
                          },
                          child: Text('D$faces', style: const TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                  ]
                  else ...[
                    const Icon(Icons.casino, size: 60, color: Colors.orange),
                    const SizedBox(height: 16),
                    const Text('O dado rolou e causou:', style: TextStyle(fontSize: 16)),
                    Text(
                        '$damageRolled de Dano',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red)
                    ),
                  ]
                ],
              ),
              actions: [
                if (damageRolled == null)
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar Ataque'),
                  ),
                if (damageRolled != null)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.attackTarget(target, damageRolled!);
                    },
                    child: const Text('Aplicar e Avançar'),
                  )
              ],
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    if (controller.winnerMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.winnerMessage!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.resetGame();
                  Navigator.pop(context);
                },
                child: const Text('Retornar ao Menu'),
              )
            ],
          ),
        ),
      );
    }

    final activeEntity = controller.activeEntity;
    final validTargets = controller.getValidTargets();

    return Scaffold(
      appBar: AppBar(title: const Text('Combate em Andamento'), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: activeEntity.isPlayer ? Colors.blue.shade800 : Colors.red.shade900,
            child: Column(
              children: [
                const Text('TURNO ATUAL', style: TextStyle(color: Colors.white70, letterSpacing: 2)),
                Text(activeEntity.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Iniciativa Interna: ${activeEntity.initiative} | HP: ${activeEntity.currentHp}', style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Selecione um Alvo para Atacar:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: validTargets.length,
              itemBuilder: (context, index) {
                final target = validTargets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.adjust, color: target.isPlayer ? Colors.blue : Colors.red),
                    title: Text(target.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('HP Atual: ${target.currentHp}/${target.maxHp}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => _showAttackDialog(context, target, controller),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}