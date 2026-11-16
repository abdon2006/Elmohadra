import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.id,
    required super.title,
    required super.filesCount,
    required super.subjectTitle,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    final files = json['files'] as List<dynamic>?;
    return ChapterModel(
      id: json['id'] as String,
      title: json['title'] as String,
      filesCount: files == null || files.isEmpty
          ? 0
          : files.first['count'] as int,
      subjectTitle: json['subjects']?['title'] as String,
    );
  }
}
