// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class Profile {
  String name;
  int level;
  int xp;
  int xpToNextLevel;
  String image;
  final Random _random = Random();

  Profile(
      {required this.name,
      required this.image,
      this.level = 1,
      this.xp = 0,
      thi})
      : xpToNextLevel = 41;

  int addRandomXp() {
    int minXp = 10 * level;
    int maxXp = 20 * level;
    int randomXp = _random.nextInt(maxXp - minXp + 1) + minXp;
    addXp(randomXp);
    return randomXp;
  }

  void addXp(int amount) {
    xp += amount;
    while (xp >= xpToNextLevel) {
      levelUp();
    }
  }

  void levelUp() {
    xp -= xpToNextLevel;
    level++;
    xpToNextLevel = (xpToNextLevel * 1.5).toInt();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}
