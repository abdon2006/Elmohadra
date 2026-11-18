import 'package:elmohadra/features/subjects/domain/usecases/get_subjects_usecase.dart';

abstract class SubjectEvents {}

class GetSubjectsEvent extends SubjectEvents {
  final GetSubjectsParams params;

  GetSubjectsEvent({required this.params});
}
