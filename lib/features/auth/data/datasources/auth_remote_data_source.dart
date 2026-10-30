import 'package:elmohadra/features/auth/data/models/user_model.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';

abstract class AuthRemoteDataSource {
  Future<void> handleSigningWithGoogle();

  Future<UserModel> signInWithEmail(SigninParams params);

  Future<UserModel> signUpWithEmail(SignupParams params);

  Future<void> signOut();

  Future<UserModel> getUserById(String userId);

  Future<AuthUserResult> getCurrentUser();

  Future<bool> checkEmailIsExist(String email);
}
