import 'package:elmohadra/features/files/domain/entities/file_entity.dart';
import 'package:equatable/equatable.dart';

class ChapterDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String subjectTitle;
  final int winConditionPercentage;
  final List<FileEntity> files;

  const ChapterDetailsEntity({
    required this.id,
    required this.title,
    required this.subjectTitle,
    required this.winConditionPercentage,
    required this.files,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subjectTitle,
    winConditionPercentage,
    files,
  ];
}
