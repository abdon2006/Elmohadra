import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/repositories/repositories/auth_repository.dart';

class SignoutUsecase extends BaseUsecase<void, NoParams> {
  final AuthRepository authRepository;
  SignoutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final response = await authRepository.signOut();
    return response;
  }
}
