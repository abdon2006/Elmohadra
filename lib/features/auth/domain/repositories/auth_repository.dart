import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> handleSigningWithGoogle();

  Future<Either<Failure, UserEntity>> signInWithEmail(SigninParams params);

  Future<Either<Failure, UserEntity>> getUserById(String userId);

  Future<Either<Failure, UserEntity>> signUpWithEmail(SignupParams params);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, AuthUserResult>> getCurrentUser();

  Future<Either<Failure, bool>> checkEmailIsExist(String email);
}
