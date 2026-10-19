import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/repositories/repositories/auth_repository.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninWithEmailUsecase extends BaseUsecase<UserEntity, SigninParams> {
  final AuthRepository authRepository;
  SigninWithEmailUsecase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(SigninParams params) async {
    final response = await authRepository.signInWithEmail(params);
    return response;
  }
}
