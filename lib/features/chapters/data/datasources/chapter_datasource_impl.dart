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
        .select(
          '*,files(id,file_title,user_file_progress(user_id)),subjects(title)',
        )
        .eq('subject_id', subjectId)
        .order('sort_order')
        .order('sort_order', referencedTable: 'files');

    // tear off
    final chapters = res.map(ChapterModel.fromJson).toList();
    return [
      ...chapters.where((chapter) => !chapter.isFinal),
      ...chapters.where((chapter) => chapter.isFinal),
    ];
  }
}
