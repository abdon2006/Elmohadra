import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/errors/repository_guard.dart';
import 'package:elmohadra/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, void>> handleSigningWithGoogle() =>
      guard(() => authRemoteDataSource.handleSigningWithGoogle());

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(SigninParams params) =>
      guard(() => authRemoteDataSource.signInWithEmail(params));

  @override
  Future<Either<Failure, void>> signOut() =>
      guard(() => authRemoteDataSource.signOut());

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail(SignupParams params) =>
      guard(() => authRemoteDataSource.signUpWithEmail(params));

  @override
  Future<Either<Failure, UserEntity>> getUserById(String userId) =>
      guard(() => authRemoteDataSource.getUserById(userId));

  @override
  Future<Either<Failure, AuthUserResult>> getCurrentUser() =>
      guard(() => authRemoteDataSource.getCurrentUser());

  @override
  Future<Either<Failure, bool>> checkEmailIsExist(String email) =>
      guard(() => authRemoteDataSource.checkEmailIsExist(email));
}
