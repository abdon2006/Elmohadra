import 'package:elmohadra/features/chapters/data/datasources/chapter_datasource.dart';
import 'package:elmohadra/features/chapters/data/models/chapter_model.dart';
import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ChapterDatasource)
class ChapterDatasourceImpl extends ChapterDatasource {
  final SupabaseClient supabaseClient;

  ChapterDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<ChapterEntity>> getChapters(String subjectId) async {
    final res = await supabaseClient
        .from('bosses')
        .select('*,files(count),subjects(title)')
        .eq('subject_id', subjectId)
        .order('sort_order');
    return res.map((c) => ChapterModel.fromJson(c)).toList();
  }
}
