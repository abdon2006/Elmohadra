import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';

abstract class FileRepository {
  Future<Either<Failure, ChapterDetailsEntity>> getChapterDetails(
    String chapterId,
  );
}
