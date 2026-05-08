import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import '../models/entity.dart';
import 'combat_screen.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  void _showFormDialog(BuildContext context, {Entity? entityToEdit, required bool isPlayer}) {
    final nameController = TextEditingController(text: entityToEdit?.name ?? '');
    final hpController = TextEditingController(text: entityToEdit?.maxHp.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entityToEdit == null ? 'Adicionar Novo' : 'Editar Entidade'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: hpController, decoration: const InputDecoration(labelText: 'HP Máximo'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final hp = int.tryParse(hpController.text) ?? 10;
              if (entityToEdit == null) {
                context.read<GameController>().addEntity(name, hp, isPlayer);
              } else {
                context.read<GameController>().updateEntity(entityToEdit.id, name, hp);
              }
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          )
        ],
      ),
    );
  }

  Widget _buildPartyList(BuildContext context, String title, List<Entity> party, bool isPlayer) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: isPlayer ? Colors.blue.shade100 : Colors.red.shade100,
              width: double.infinity,
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: party.length,
                itemBuilder: (context, index) {
                  final entity = party[index];
                  return ListTile(
                    title: Text(entity.name),
                    subtitle: Text('HP: ${entity.maxHp}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.grey), onPressed: () => _showFormDialog(context, entityToEdit: entity, isPlayer: isPlayer)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => context.read<GameController>().deleteEntity(entity.id)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () => _showFormDialog(context, isPlayer: isPlayer),
                icon: const Icon(Icons.add),
                label: Text('Adicionar ${isPlayer ? "Herói" : "Inimigo"}'),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Preparar Combate')),
      body: Column(
        children: [
          _buildPartyList(context, 'Aventureiros', controller.players, true),
          _buildPartyList(context, 'Inimigos', controller.enemies, false),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent, padding: const EdgeInsets.all(16)),
              onPressed: (controller.players.isEmpty || controller.enemies.isEmpty)
                  ? null
                  : () {
                context.read<GameController>().startCombat();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CombatScreen()));
              },
              child: const Text('RODAR INICIATIVA E INICIAR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}