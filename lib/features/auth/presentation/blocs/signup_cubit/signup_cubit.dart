import 'package:elmohadra/features/auth/presentation/blocs/signup_cubit/signup_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupCubit extends Cubit<SignupCubitState> {
  SignupCubit() : super(SignupCubitState());

  // for redirection from google
  void initGoogleDate({required String email}) =>
      emit(state.copyWith(email: email));

  void updateCredentialData({
    required String email,
    required String password,
  }) => emit(state.copyWith(email: email, password: password));

  void updateNameData({required String name, required String nickName}) =>
      emit(state.copyWith(name: name, nickName: nickName));

  void updateUniversityInfo({
    required String universityName,
    required int academicYear,
  }) => emit(
    state.copyWith(universityName: universityName, academicYear: academicYear),
  );

  void updateAvatarKey({required String avatarKey}) {
    emit(state.copyWith(avatarKey: avatarKey));
  }
}
