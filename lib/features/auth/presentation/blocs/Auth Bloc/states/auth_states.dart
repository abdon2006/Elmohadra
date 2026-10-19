import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AuthStates extends Equatable {}

class AuthInitial extends AuthStates {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthStates {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthStates {
  final String message;
  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthAuthenticated extends AuthStates {
  final UserEntity user;
  AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthNewUser extends AuthStates {
  final AuthUserResult user;
  AuthNewUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnAuthenticated extends AuthStates {
  @override
  List<Object?> get props => [];
}
