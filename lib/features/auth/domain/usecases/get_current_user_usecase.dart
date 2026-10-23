import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUsecase extends BaseUsecase<AuthUserResult, NoParams> {
  final AuthRepository authRepository;
  GetCurrentUserUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthUserResult>> call(NoParams params) async {
    final res = authRepository.getCurrentUser();
    return res;
  }
}
