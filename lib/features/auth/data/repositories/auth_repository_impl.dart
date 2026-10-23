import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, void>> handleSigningWithGoogle() async {
    try {
      final res = await authRemoteDataSource.handleSigningWithGoogle();
      return Right(res);
    } catch (e) {
      return switch (e) {
        AuthException() => Left(AuthFailure(message: e.toString())),
        PostgrestException() => Left(ServerFailure(message: e.toString())),
        SocketException() => Left(NetworkFailure(message: e.toString())),
        _ => Left(ServerFailure(message: e.toString())),
      };
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
    SigninParams params,
  ) async {
    try {
      final res = await authRemoteDataSource.signInWithEmail(params);
      return Right(res);
    } catch (e) {
      return switch (e) {
        AuthException() => Left(AuthFailure(message: e.toString())),
        PostgrestException() => Left(ServerFailure(message: e.toString())),
        SocketException() => Left(NetworkFailure(message: e.toString())),
        _ => Left(ServerFailure(message: e.toString())),
      };
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final res = await authRemoteDataSource.signOut();
      return Right(res);
    } catch (e) {
      return switch (e) {
        AuthException() => Left(AuthFailure(message: e.toString())),
        PostgrestException() => Left(ServerFailure(message: e.toString())),
        SocketException() => Left(NetworkFailure(message: e.toString())),
        _ => Left(ServerFailure(message: e.toString())),
      };
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail(
    SignupParams params,
  ) async {
    try {
      final res = await authRemoteDataSource.signUpWithEmail(params);
      return Right(res);
    } catch (e) {
      return switch (e) {
        AuthException() => Left(AuthFailure(message: e.toString())),
        PostgrestException() => Left(ServerFailure(message: e.toString())),
        SocketException() => Left(NetworkFailure(message: e.toString())),
        _ => Left(ServerFailure(message: e.toString())),
      };
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String userId) async {
    try {
      final res = await authRemoteDataSource.getUserById(userId);
      return Right(res);
    } catch (e) {
      return switch (e) {
        AuthException() => Left(AuthFailure(message: e.toString())),
        PostgrestException() => Left(ServerFailure(message: e.toString())),
        SocketException() => Left(NetworkFailure(message: e.toString())),
        _ => Left(ServerFailure(message: e.toString())),
      };
    }
  }

  @override
  Future<Either<Failure, AuthUserResult>> getCurrentUser() async {
    try {
      final res = await authRemoteDataSource.getCurrentUser();
      return Right(res);
    } catch (e) {
      print(
        " ------------- catching error i getCurrent USer in AuthRepo Impl : ${e.toString()} -------",
      );
      return switch (e) {
        AuthException() => Left(AuthFailure(message: e.toString())),
        PostgrestException() => Left(ServerFailure(message: e.toString())),
        SocketException() => Left(NetworkFailure(message: e.toString())),
        _ => Left(ServerFailure(message: e.toString())),
      };
    }
  }
}
