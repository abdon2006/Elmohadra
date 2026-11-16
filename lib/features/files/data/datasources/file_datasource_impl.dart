import 'package:elmohadra/features/files/data/datasources/file_datasource.dart';
import 'package:elmohadra/features/files/data/models/chapter_details_model.dart';
import 'package:elmohadra/features/files/data/models/file_model.dart';
import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: FileDatasource)
class FileDatasourceImpl extends FileDatasource {
  final SupabaseClient supabaseClient;

  FileDatasourceImpl({required this.supabaseClient});

  @override
  Future<ChapterDetailsEntity> getChapterDetails(String chapterId) async {
    final res = await supabaseClient
        .from('bosses')
        .select('*,files(id,file_title),subjects(title)')
        .eq('id', chapterId)
        .order('sort_order', referencedTable: 'files')
        .single();
    final files = (res['files'] as List)
        .map((f) => FileModel.fromJson(f))
        .toList();
    return ChapterDetailsModel.fromJson(res, files);
  }
}
