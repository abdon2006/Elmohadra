import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/repositories/repositories/auth_repository.dart';

class SigninWithGoogle extends BaseUsecase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  SigninWithGoogle({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    final response = await authRepository.signInWithGoogle();
    return response;
  }
}
