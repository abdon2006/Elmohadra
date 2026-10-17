import 'package:equatable/equatable.dart';

enum UserStatus { active, banned }

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String nickname;
  final String email;
  final String university;
  final int academicYear;
  final int level;
  final int xp;
  final int totalBattles;
  final int wonBattles;
  final int defeatBattles;
  final int drawBattles;
  final int coins;
  final String avatarKey;
  final DateTime createdAt;
  final UserStatus status;

  const UserEntity({
    required this.id,
    required this.name,
    required this.nickname,
    required this.email,
    required this.university,
    required this.academicYear,
    required this.level,
    required this.xp,
    required this.totalBattles,
    required this.wonBattles,
    required this.defeatBattles,
    required this.drawBattles,
    required this.coins,
    required this.avatarKey,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    nickname,
    email,
    university,
    academicYear,
    level,
    xp,
    totalBattles,
    wonBattles,
    defeatBattles,
    drawBattles,
    coins,
    avatarKey,
    createdAt,
    status,
  ];
}
