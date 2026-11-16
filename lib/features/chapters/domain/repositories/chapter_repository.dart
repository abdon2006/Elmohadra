import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';

abstract class ChapterRepository {
  Future<Either<Failure, List<ChapterEntity>>> getChapters(String subjectId);
}
