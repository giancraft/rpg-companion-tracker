import 'package:flutter/foundation.dart';

class Entity {
  final String id;
  final String name;
  final int maxHp;
  int currentHp;
  final int initiative;

  Entity({
    required this.id,
    required this.name,
    required this.maxHp,
    required this.currentHp,
    required this.initiative,
  });

  void takeDamage(int amount) {
    currentHp -= amount;
    if (currentHp < 0) currentHp = 0;
  }

  void heal(int amount) {
    currentHp += amount;
    if (currentHp > maxHp) currentHp = maxHp;
  }

  bool get isDead => currentHp <= 0;
}