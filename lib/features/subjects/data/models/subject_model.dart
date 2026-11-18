import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required super.academicYear,
    required super.title,
    required super.id,
    required super.chapterCount,
    required super.filesCount,
    required super.completedFiles,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    final bosses = json['bosses'] as List<dynamic>? ?? [];
    int filesCount = 0;
    int completedFiles = 0;
    int chapterCount = 0;
    for (final boss in bosses) {
      if (boss['kind'] == 'final') continue;
      chapterCount++;
      final files = boss['files'] as List?;
      filesCount += files?.length ?? 0;
      if (files == null) continue;
      for (var file in files) {
        if ((file['user_file_progress'] as List).isNotEmpty) completedFiles++;
      }
    }
    return SubjectModel(
      academicYear: json['academic_year'] as int,
      title: json['title'] as String,
      id: json['id'] as String,
      chapterCount: chapterCount,
      filesCount: filesCount,
      completedFiles: completedFiles,
    );
  }
}
