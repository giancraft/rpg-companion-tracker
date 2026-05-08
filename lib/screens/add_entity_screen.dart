import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/combat_controller.dart';
import '../models/entity.dart';

class AddEntityScreen extends StatefulWidget {
  const AddEntityScreen({super.key});

  @override
  State<AddEntityScreen> createState() => _AddEntityScreenState();
}

class _AddEntityScreenState extends State<AddEntityScreen> {
  final _nameController = TextEditingController();
  final _hpController = TextEditingController();
  final _initController = TextEditingController();

  void _saveEntity() {
    if (_nameController.text.isEmpty || _hpController.text.isEmpty || _initController.text.isEmpty) return;

    final newEntity = Entity(
      id: DateTime.now().toString(),
      name: _nameController.text,
      maxHp: int.parse(_hpController.text),
      currentHp: int.parse(_hpController.text),
      initiative: int.parse(_initController.text),
    );

    context.read<CombatController>().addEntity(newEntity);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Personagem/Monstro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _hpController,
              decoration: const InputDecoration(labelText: 'HP Máximo'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _initController,
              decoration: const InputDecoration(labelText: 'Iniciativa'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEntity,
              child: const Text('Adicionar ao Combate'),
            )
          ],
        ),
      ),
    );
  }
}