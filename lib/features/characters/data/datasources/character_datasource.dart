import 'package:elmohadra/features/characters/data/models/character_model.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> getCharacters();
}
