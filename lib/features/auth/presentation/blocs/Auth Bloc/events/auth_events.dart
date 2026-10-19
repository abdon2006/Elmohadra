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
