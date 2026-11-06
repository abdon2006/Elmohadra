import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUsecase extends BaseUsecase<void, String> {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(String newPassword) async =>
      await authRepository.resetPassword(newPassword);
}
