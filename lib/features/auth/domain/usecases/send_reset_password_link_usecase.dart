import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendResetPasswordLinkUsecase extends BaseUsecase<void, String> {
  final AuthRepository authRepository;

  SendResetPasswordLinkUsecase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(String email) async =>
      await authRepository.sendResetPasswordLink(email);
}
