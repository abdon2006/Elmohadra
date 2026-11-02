import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failure_mapper.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/characters/data/datasources/character_datasource.dart';
import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';
import 'package:elmohadra/features/characters/domain/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl extends CharacterRepository {
  final CharacterDatasource characterDatasource;

  CharacterRepositoryImpl({required this.characterDatasource});

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } catch (e) {
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getCharacters() =>
      _guard(() => characterDatasource.getCharacters());
}
