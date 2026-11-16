import 'package:equatable/equatable.dart';

class ChapterEntity extends Equatable {
  final String id;
  final String title;
  final int filesCount;
  final String subjectTitle;

  const ChapterEntity({
    required this.id,
    required this.title,
    required this.filesCount,
    required this.subjectTitle,
  });

  int get stagesCount => filesCount + 1;

  @override
  List<Object?> get props => [id, title, filesCount, subjectTitle];
}
