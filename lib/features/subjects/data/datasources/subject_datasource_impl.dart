import 'package:elmohadra/features/subjects/data/datasources/subject_datasource.dart';
import 'package:elmohadra/features/subjects/data/models/subject_model.dart';
import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:elmohadra/features/subjects/domain/usecases/get_subjects_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SubjectDatasource)
class SubjectDatasourceImpl extends SubjectDatasource {
  final SupabaseClient supabaseClient;

  SubjectDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<SubjectEntity>> getSubjects(GetSubjectsParams params) async {
    // TODO: we transform the 'eq' check to match cause we was planning to make the check with the
    // TODO :  yeara and also with the college id to prevent appear the wrong subjects to different colleges
    // TODO : but that need the userEntity To bee edited to carry the collegeID and we will do that later
    final res = await supabaseClient
        .from('subjects')
        .select('*, bosses(id,kind,files(id,user_file_progress(user_id)))')
        .match({'academic_year': params.year})
        .order('sort_order');
    return res.map((s) => SubjectModel.fromJson(s)).toList();
  }
}
