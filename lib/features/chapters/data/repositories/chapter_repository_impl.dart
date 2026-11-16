import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/errors/repository_guard.dart';
import 'package:elmohadra/features/chapters/data/datasources/chapter_datasource.dart';
import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';
import 'package:elmohadra/features/chapters/domain/repositories/chapter_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChapterRepository)
class ChapterRepositoryImpl extends ChapterRepository {
  final ChapterDatasource chapterDatasource;

  ChapterRepositoryImpl({required this.chapterDatasource});

  @override
  Future<Either<Failure, List<ChapterEntity>>> getChapters(String subjectId) =>
      guard(() => chapterDatasource.getChapters(subjectId));
}
