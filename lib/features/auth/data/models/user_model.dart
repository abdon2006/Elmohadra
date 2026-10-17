import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.nickname,
    required super.email,
    required super.university,
    required super.academicYear,
    required super.level,
    required super.xp,
    required super.totalBattles,
    required super.wonBattles,
    required super.defeatBattles,
    required super.drawBattles,
    required super.coins,
    required super.avatarKey,
    required super.createdAt,
    required super.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      university: json['university'] as String,
      academicYear: json['academic_year'] as int,
      level: json['level'] as int,
      xp: json['xp'] as int,
      totalBattles: json['total_battles'] as int,
      wonBattles: json['won_battles'] as int,
      defeatBattles: json['defeat_battles'] as int,
      drawBattles: json['draw_battles'] as int,
      coins: json['coins'] as int,
      avatarKey: json['avatar_key'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: UserStatus.values.byName(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'email': email,
      'university': university,
      'academic_year': academicYear,
      'level': level,
      'xp': xp,
      'total_battles': totalBattles,
      'won_battles': wonBattles,
      'defeat_battles': defeatBattles,
      'draw_battles': drawBattles,
      'coins': coins,
      'avatar_key': avatarKey,
      'created_at': createdAt.toIso8601String(),
      'status': status.name,
    };
  }
}
