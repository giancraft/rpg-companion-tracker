import 'package:flutter/material.dart';
import 'dart:math';
import '../models/entity.dart';

class GameController extends ChangeNotifier {
  final List<Entity> _entities = [];
  int _currentTurnIndex = 0;
  String? _winnerMessage;

  List<Entity> get players => _entities.where((e) => e.isPlayer).toList();
  List<Entity> get enemies => _entities.where((e) => !e.isPlayer).toList();
  List<Entity> get combatOrder => _entities;
  Entity get activeEntity => _entities[_currentTurnIndex];
  String? get winnerMessage => _winnerMessage;

  void addEntity(String name, int hp, bool isPlayer) {
    _entities.add(Entity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      maxHp: hp,
      currentHp: hp,
      isPlayer: isPlayer,
    ));
    notifyListeners();
  }

  void updateEntity(String id, String name, int hp) {
    final entity = _entities.firstWhere((e) => e.id == id);
    entity.update(newName: name, newMaxHp: hp);
    notifyListeners();
  }

  void deleteEntity(String id) {
    _entities.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void startCombat() {
    final random = Random();

    for (var entity in _entities) {
      entity.initiative = random.nextInt(20) + 1;
    }

    _entities.sort((a, b) {
      if (a.isPlayer && !b.isPlayer) return -1;
      if (!a.isPlayer && b.isPlayer) return 1;

      return b.initiative.compareTo(a.initiative);
    });

    _currentTurnIndex = 0;
    _winnerMessage = null;
    notifyListeners();
  }

  List<Entity> getValidTargets() {
    return _entities.where((e) => !e.isDead && e.isPlayer != activeEntity.isPlayer).toList();
  }

  void attackTarget(Entity target, int damage) {
    target.takeDamage(damage);
    _checkWinCondition();

    if (_winnerMessage == null) {
      _nextTurn();
    } else {
      notifyListeners();
    }
  }

  void _nextTurn() {
    do {
      _currentTurnIndex++;
      if (_currentTurnIndex >= _entities.length) {
        _currentTurnIndex = 0;
      }
    } while (_entities[_currentTurnIndex].isDead);
    notifyListeners();
  }

  void _checkWinCondition() {
    final allPlayersDead = players.every((p) => p.isDead);
    final allEnemiesDead = enemies.every((e) => e.isDead);

    if (allPlayersDead) {
      _winnerMessage = "Derrota! Os inimigos venceram o combate.";
    } else if (allEnemiesDead) {
      _winnerMessage = "Vitória! Os aventureiros limparam a área.";
    }
  }

  void resetGame() {
    _entities.clear();
    _winnerMessage = null;
    notifyListeners();
  }
}