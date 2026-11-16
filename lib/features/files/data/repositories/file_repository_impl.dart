import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/errors/repository_guard.dart';
import 'package:elmohadra/features/files/data/datasources/file_datasource.dart';
import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';
import 'package:elmohadra/features/files/domain/repositories/file_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FileRepository)
class FileRepositoryImpl extends FileRepository {
  final FileDatasource fileDatasource;

  FileRepositoryImpl({required this.fileDatasource});

  @override
  Future<Either<Failure, ChapterDetailsEntity>> getChapterDetails(
    String chapterId,
  ) => guard(() => fileDatasource.getChapterDetails(chapterId));
}
