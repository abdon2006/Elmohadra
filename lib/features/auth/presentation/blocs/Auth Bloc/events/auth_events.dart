import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {}

class CheckAuthStatusEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}

class HandleSigningWithGoogleEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}

class DeepLinkReceivedEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}

class SendResetPasswordLinkEvent extends AuthEvents {
  final String email;

  SendResetPasswordLinkEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordResetLinkReceivedEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}

class UpdatePasswordEvent extends AuthEvents {
  final String password;

  UpdatePasswordEvent({required this.password});

  @override
  List<Object?> get props => [password];
}
