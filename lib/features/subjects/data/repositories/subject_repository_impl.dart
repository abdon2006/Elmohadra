import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/errors/repository_guard.dart';
import 'package:elmohadra/features/subjects/data/datasources/subject_datasource.dart';
import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:elmohadra/features/subjects/domain/repositories/subject_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SubjectRepository)
class SubjectRepositoryImpl extends SubjectRepository {
  final SubjectDatasource subjectDatasource;

  SubjectRepositoryImpl({required this.subjectDatasource});

  @override
  Future<Either<Failure, List<SubjectEntity>>> getSubjects(int year) =>
      guard(() => subjectDatasource.getSubjects(year));
}
