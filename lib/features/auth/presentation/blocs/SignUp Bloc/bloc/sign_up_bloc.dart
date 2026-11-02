import 'package:elmohadra/features/auth/domain/usecases/check_email_is_exist_usecase.dart';
import 'package:elmohadra/features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/events/sing_up_bloc_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/states/sign_up_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpBloc extends Bloc<SignUpBlocEvents, SignUpStates> {
  final SignupWithEmailUsecase signupWithEmailUsecase;
  final CheckEmailIsExistUsecase checkEmailIsExistUsecase;

  SignUpBloc({
    required this.signupWithEmailUsecase,
    required this.checkEmailIsExistUsecase,
  }) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      final res = await signupWithEmailUsecase(event.params);
      res.fold((l) => emit(SignUpError(failure: l)), (r) {
        emit(SignUpSuccess(user: r));
      });
    });
    on<CheckEmailIsExist>((event, emit) async {
      emit(SignUpLoading());
      final res = await checkEmailIsExistUsecase(event.email);
      res.fold(
        (l) => emit(SignUpError(failure: l)),
        (r) => emit(EmailIsExist(isExist: r)),
      );
    });
  }
}
