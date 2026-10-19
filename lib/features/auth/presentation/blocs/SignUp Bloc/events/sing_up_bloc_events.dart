// events
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpBlocEvents extends Equatable {}

class SignUpEvent extends SignUpBlocEvents {
  final SignupParams params;
  SignUpEvent({required this.params});
  @override
  List<Object?> get props => [params];
}