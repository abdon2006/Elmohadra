import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/repositories/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserByIdUsecase extends BaseUsecase<UserEntity, String> {
  final AuthRepository authRepository;
  GetUserByIdUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(String userId) async {
    final res = await authRepository.getUserById(userId);
    return res;
  }
}
