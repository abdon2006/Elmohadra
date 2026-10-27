import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;
  final String titleAr;
  final String titleEn;
  final int coinsToUnlock;
  final int level;
  final bool isLocked;
  final String imageUrl;
  final String characterKey;

  const CharacterEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.titleAr,
    required this.titleEn,
    required this.coinsToUnlock,
    required this.level,
    required this.isLocked,
    required this.imageUrl,
    required this.characterKey,
  });

  @override
  List<Object?> get props => [
    id,
    nameEn,
    nameAr,
    titleAr,
    titleEn,
    coinsToUnlock,
    level,
    isLocked,
    imageUrl,
    characterKey,
  ];
}
