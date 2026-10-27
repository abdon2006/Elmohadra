import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/characters/data/datasources/character_datasource.dart';
import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';
import 'package:elmohadra/features/characters/domain/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl extends CharacterRepository {
  final CharacterDatasource characterDatasource;

  CharacterRepositoryImpl({required this.characterDatasource});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getCharacters() async {
    try {
      final res = await characterDatasource.getCharacters();
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
      // that is temp w will make a switch on the code of the failure to handle the message provided
    }
  }
}
