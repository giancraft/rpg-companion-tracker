import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/combat_controller.dart';
import 'add_entity_screen.dart';
import 'dice_screen.dart';

class CombatScreen extends StatefulWidget {
  const CombatScreen({super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordem de Iniciativa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DiceScreen()),
            ),
          ),
        ],
      ),
      body: Consumer<CombatController>(
        builder: (context, controller, child) {
          return ListView.builder(
            itemCount: controller.entities.length,
            itemBuilder: (context, index) {
              final entity = controller.entities[index];
              return Card(
                color: entity.isDead ? Colors.red.shade100 : Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    entity.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Iniciativa: ${entity.initiative} | HP: ${entity.currentHp}/${entity.maxHp}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => controller.applyDamage(entity.id, 5),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () => controller.applyHealing(entity.id, 5),
                      ),
                    ],
                  ),
                  onLongPress: () => controller.removeEntity(entity.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddEntityScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}