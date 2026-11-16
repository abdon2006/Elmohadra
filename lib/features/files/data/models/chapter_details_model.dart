import 'package:elmohadra/features/files/data/models/file_model.dart';
import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';

class ChapterDetailsModel extends ChapterDetailsEntity {
  const ChapterDetailsModel({
    required super.id,
    required super.title,
    required super.subjectTitle,
    required super.winConditionPercentage,
    required super.files,
  });

  factory ChapterDetailsModel.fromJson(
    Map<String, dynamic> json,
    List<FileModel> files,
  ) {
    return ChapterDetailsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subjectTitle: json['subjects']['title'] as String,
      winConditionPercentage: json['win_condition_percentage'] as int,
      files: files,
    );
  }
}
