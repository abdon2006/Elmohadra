import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:elmohadra/features/subjects/domain/usecases/get_subjects_usecase.dart';

abstract class SubjectDatasource {
  Future<List<SubjectEntity>> getSubjects(GetSubjectsParams params);
}
