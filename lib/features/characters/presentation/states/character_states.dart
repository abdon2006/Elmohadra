import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/characters/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterStates extends Equatable {}

class CharacterInitial extends CharacterStates {
  @override
  List<Object?> get props => [];
}

class CharacterLoading extends CharacterStates {
  @override
  List<Object?> get props => [];
}

class CharacterIError extends CharacterStates {
  final Failure failure;

  CharacterIError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class GetCharactersSuccess extends CharacterStates {
  final List<CharacterEntity> characters;

  GetCharactersSuccess({required this.characters});

  @override
  List<Object?> get props => [characters];
}
