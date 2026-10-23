import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/errors/failures.dart';

sealed class SignInBlocStates extends Equatable {}

class SigninBlocInitial extends SignInBlocStates {
  @override
  List<Object?> get props => [];
}

class SigninBlocLoading extends SignInBlocStates {
  @override
  List<Object?> get props => [];
}

class SigninBlocError extends SignInBlocStates {
  final String message;
  final Failure failure;

  SigninBlocError({required this.message, required this.failure});

  @override
  List<Object?> get props => [message];
}

class SigninBlocSuccess extends SignInBlocStates {
  final UserEntity user;

  SigninBlocSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}
