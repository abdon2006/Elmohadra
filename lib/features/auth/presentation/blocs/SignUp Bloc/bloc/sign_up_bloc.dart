import 'package:elmohadra/features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/events/sing_up_bloc_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/states/sign_up_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpBloc extends Bloc<SignUpBlocEvents, SignUpStates> {
  final SignupWithEmailUsecase signupWithEmailUsecase;

  SignUpBloc({required this.signupWithEmailUsecase})
    : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      final res = await signupWithEmailUsecase(event.params);
      res.fold(
        (l) => emit(SignUpError(message: l.message)),
        (r) => emit(SignUpSuccess(user: r)),
      );
    });
  }
}