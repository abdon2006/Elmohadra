import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckEmailIsExistUsecase extends BaseUsecase<bool, String> {
  final AuthRepository authRepository;

  CheckEmailIsExistUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(String email) async {
    final res = await authRepository.checkEmailIsExist(email);
    return res;
  }
}
