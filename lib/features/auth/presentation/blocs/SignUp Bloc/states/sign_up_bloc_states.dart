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
  SignUpError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SignUpSuccess extends SignUpStates {
  final UserEntity user;
  SignUpSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}
