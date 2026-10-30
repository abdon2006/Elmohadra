import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class SignUpStates extends Equatable {}

class SignUpInitial extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class SignUpLoading extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class SignUpError extends SignUpStates {
  final String message;
  final Failure failure;

  SignUpError({required this.message, required this.failure});

  @override
  List<Object?> get props => [message, failure];
}

class SignUpSuccess extends SignUpStates {
  final UserEntity user;

  SignUpSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class EmailIsExist extends SignUpStates {
  final bool isExist;

  EmailIsExist({required this.isExist});

  @override
  List<Object?> get props => [isExist];
}
