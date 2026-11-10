import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required super.academicYear,
    required super.title,
    required super.id,
    required super.chapterCount,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    final bosses = json['bosses'] as List<dynamic>;
    return SubjectModel(
      academicYear: json['academic_year'] as int,
      title: json['title'] as String,
      id: json['id'] as String,
      chapterCount: bosses.isEmpty
          ? 0
          : (bosses.first as Map<String, dynamic>)['count'] as int,
    );
  }
}
