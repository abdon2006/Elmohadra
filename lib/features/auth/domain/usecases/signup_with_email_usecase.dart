import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/repositories/repositories/auth_repository.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';

class SignupWithEmailUsecase extends BaseUsecase<UserEntity, SignupParams> {
  final AuthRepository authRepository;
  SignupWithEmailUsecase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(SignupParams params) async {
    final response = await authRepository.signUpWithEmail(params);
    return response;
  }
}
