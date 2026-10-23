import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class HandleSigningWithGoogleUsecase extends BaseUsecase<void, NoParams> {
  final AuthRepository authRepository;
  HandleSigningWithGoogleUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final response = await authRepository.handleSigningWithGoogle();
    return response;
  }
}
