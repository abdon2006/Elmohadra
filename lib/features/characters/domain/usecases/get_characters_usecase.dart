import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';
import 'package:elmohadra/features/characters/domain/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCharactersUsecase
    extends BaseUsecase<List<CharacterEntity>, NoParams> {
  final CharacterRepository characterRepository;

  GetCharactersUsecase({required this.characterRepository});

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(NoParams params) async {
    final res = await characterRepository.getCharacters();
    return res;
  }
}
