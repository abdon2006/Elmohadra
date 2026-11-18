import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.id,
    required super.title,
    required super.filesCount,
    required super.subjectTitle,
    required super.completedFiles,
    required super.isFinal,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    final files = json['files'] as List<dynamic>? ?? [];
    int completedFiles = 0;
    for (var file in files) {
      if ((file['user_file_progress'] as List? ?? []).isNotEmpty) {
        completedFiles++;
      }
    }
    return ChapterModel(
      id: json['id'] as String,
      title: json['title'] as String,
      filesCount: files.length,
      subjectTitle: json['subjects']?['title'] as String? ?? '',
      completedFiles: completedFiles,
      isFinal: json['kind'] == 'final',
    );
  }
}
