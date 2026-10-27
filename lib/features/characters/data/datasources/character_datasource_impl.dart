import 'package:elmohadra/features/characters/data/datasources/character_datasource.dart';
import 'package:elmohadra/features/characters/data/models/character_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: CharacterDatasource)
class CharacterDatasourceImpl extends CharacterDatasource {
  final SupabaseClient supabaseClient;

  CharacterDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final res = await supabaseClient.from('characters').select();
    return res.map((c) => CharacterModel.fromJson(c)).toList();
  }
}
