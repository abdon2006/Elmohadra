import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';

class AuthUserResult {
  final UserEntity? existingUser;
  final String? newUserId;
  final String? newUseremail;

  const AuthUserResult({this.existingUser, this.newUserId, this.newUseremail});
}
