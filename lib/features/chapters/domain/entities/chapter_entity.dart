import 'package:equatable/equatable.dart';

class ChapterEntity extends Equatable {
  final String id;
  final String title;
  final int filesCount;
  final String subjectTitle;
  final int completedFiles;
  final bool isFinal;

  const ChapterEntity({
    required this.id,
    required this.title,
    required this.filesCount,
    required this.subjectTitle,
    required this.completedFiles,
    required this.isFinal,
  });

  double get fileProgress {
    if (filesCount == 0) return 0;
    return completedFiles / filesCount;
  }

  int get stagesCount => filesCount + 1;

  @override
  List<Object?> get props => [
    id,
    title,
    filesCount,
    subjectTitle,
    completedFiles,
    isFinal,
  ];
}
