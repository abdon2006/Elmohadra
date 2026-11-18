import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:elmohadra/features/subjects/domain/usecases/get_subjects_usecase.dart';

abstract class SubjectRepository {
  Future<Either<Failure, List<SubjectEntity>>> getSubjects(
    GetSubjectsParams params,
  );
}
