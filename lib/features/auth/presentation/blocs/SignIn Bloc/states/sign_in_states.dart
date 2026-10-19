import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

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
  SigninBlocError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SigninBlocSuccess extends SignInBlocStates {
  final UserEntity user;
  SigninBlocSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}
