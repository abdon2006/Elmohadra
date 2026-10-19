import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:equatable/equatable.dart';

abstract class SignInBlocEvents extends Equatable {}

class SignInEvent extends SignInBlocEvents {
  final SigninParams params;
  SignInEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
