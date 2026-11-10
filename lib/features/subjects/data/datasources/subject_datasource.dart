import 'package:elmohadra/features/subjects/data/models/subject_model.dart';

abstract class SubjectDatasource {
  Future<List<SubjectModel>> getSubjects(int year);
}
