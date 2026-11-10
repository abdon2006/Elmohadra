import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:elmohadra/features/subjects/domain/repositories/subject_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubjectsUsecase extends BaseUsecase<List<SubjectEntity>, int> {
  final SubjectRepository subjectRepository;

  GetSubjectsUsecase({required this.subjectRepository});

  @override
  Future<Either<Failure, List<SubjectEntity>>> call(int year) =>
      subjectRepository.getSubjects(year);
}
