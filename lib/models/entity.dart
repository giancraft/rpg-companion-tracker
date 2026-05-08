class Entity {
  String id;
  String name;
  int maxHp;
  int currentHp;
  bool isPlayer;
  int initiative;

  Entity({
    required this.id,
    required this.name,
    required this.maxHp,
    required this.currentHp,
    required this.isPlayer,
    this.initiative = 0,
  });

  void takeDamage(int damage) {
    currentHp -= damage;
    if (currentHp < 0) currentHp = 0;
  }

  bool get isDead => currentHp <= 0;

  void update({required String newName, required int newMaxHp}) {
    name = newName;
    maxHp = newMaxHp;
    if (currentHp > maxHp) currentHp = maxHp;
  }
}