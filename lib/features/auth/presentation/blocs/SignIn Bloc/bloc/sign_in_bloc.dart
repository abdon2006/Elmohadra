import 'package:elmohadra/features/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/events/sign_in_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/states/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInBloc extends Bloc<SignInBlocEvents, SignInBlocStates> {
  final SigninWithEmailUsecase signinWithEmailUsecase;

  SignInBloc({required this.signinWithEmailUsecase})
    : super(SigninBlocInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(SigninBlocLoading());
      final res = await signinWithEmailUsecase(event.params);
      res.fold((l) => emit(SigninBlocError(message: l.message, failure: l)), (
        r,
      ) {
        emit(SigninBlocSuccess(user: r));
      });
    });
  }
}
