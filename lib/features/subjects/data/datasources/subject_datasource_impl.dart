import 'package:elmohadra/features/subjects/data/datasources/subject_datasource.dart';
import 'package:elmohadra/features/subjects/data/models/subject_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SubjectDatasource)
class SubjectDatasourceImpl extends SubjectDatasource {
  final SupabaseClient supabaseClient;

  SubjectDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<SubjectModel>> getSubjects(int year) async {
    final res = await supabaseClient
        .from('subjects')
        .select('*, bosses(count)')
        .eq('academic_year', year)
        .order('title');
    return res.map((s) => SubjectModel.fromJson(s)).toList();
  }
}
