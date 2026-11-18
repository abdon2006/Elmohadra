import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  final String id;
  final String title;
  final int academicYear;
  final int chapterCount;
  final int filesCount;
  final int completedFiles;

  const SubjectEntity({
    required this.id,
    required this.title,
    required this.academicYear,
    required this.filesCount,
    required this.chapterCount,
    required this.completedFiles,
  });

  double get fileProgress {
    if (filesCount == 0) return 0;
    return completedFiles / filesCount;
  }

  @override
  List<Object?> get props => [
    id,
    title,
    academicYear,
    chapterCount,
    filesCount,
    completedFiles,
  ];
}
