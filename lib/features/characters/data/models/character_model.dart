import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.titleAr,
    required super.titleEn,
    required super.coinsToUnlock,
    required super.level,
    required super.isLocked,
    required super.imageUrl,
    required super.characterKey,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      coinsToUnlock: json['coins_to_unlock'] as int,
      level: json['level'] as int,
      isLocked: json['is_locked'] as bool,
      imageUrl: json['image_url'] as String,
      characterKey: json['key'] as String,
    );
  }
}
