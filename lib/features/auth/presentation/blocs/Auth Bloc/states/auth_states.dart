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
  final bool isGoogleSignIn;

  AuthAuthenticated({required this.user, this.isGoogleSignIn = false});

  @override
  List<Object?> get props => [user, isGoogleSignIn];
}

class AuthNewUser extends AuthStates {
  final AuthUserResult user;
  final bool isGoogleSignIn;

  AuthNewUser({required this.user, this.isGoogleSignIn = false});

  @override
  List<Object?> get props => [user, isGoogleSignIn];
}

class AuthUnAuthenticated extends AuthStates {
  @override
  List<Object?> get props => [];
}
