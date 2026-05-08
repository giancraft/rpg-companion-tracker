import 'package:flutter/material.dart';
import '../models/entity.dart';

class CombatController extends ChangeNotifier {
  final List<Entity> _entities = [
    Entity(id: '1', name: 'Clérigo da Ordem', maxHp: 45, currentHp: 45, initiative: 18),
    Entity(id: '2', name: 'Paladino', maxHp: 55, currentHp: 55, initiative: 12),
    Entity(id: '3', name: 'Ladino', maxHp: 35, currentHp: 35, initiative: 22),
    Entity(id: '4', name: 'Mago', maxHp: 28, currentHp: 28, initiative: 10),
    Entity(id: '5', name: 'Guerreiro', maxHp: 60, currentHp: 60, initiative: 14),
    Entity(id: '6', name: 'Diabo de Avernus', maxHp: 120, currentHp: 120, initiative: 15),
  ];

  CombatController() {
    _sortInitiative();
  }

  List<Entity> get entities => _entities;

  void addEntity(Entity entity) {
    _entities.add(entity);
    _sortInitiative();
    notifyListeners();
  }

  void applyDamage(String id, int amount) {
    final entity = _entities.firstWhere((e) => e.id == id);
    entity.takeDamage(amount);
    notifyListeners();
  }

  void applyHealing(String id, int amount) {
    final entity = _entities.firstWhere((e) => e.id == id);
    entity.heal(amount);
    notifyListeners();
  }

  void removeEntity(String id) {
    _entities.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void _sortInitiative() {
    _entities.sort((a, b) => b.initiative.compareTo(a.initiative));
  }
}