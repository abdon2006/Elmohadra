abstract class SubjectEvents {}

class GetSubjectsEvent extends SubjectEvents {
  final int academicYear;

  GetSubjectsEvent({required this.academicYear});
}
