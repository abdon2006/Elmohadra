import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  final String id;
  final String title;
  final int academicYear;
  final int chapterCount;

  const SubjectEntity({
    required this.id,
    required this.title,
    required this.academicYear,
    this.chapterCount = 0,
  });

  @override
  List<Object?> get props => [id, title, academicYear, chapterCount];
}
