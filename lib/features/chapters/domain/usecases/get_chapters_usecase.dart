import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';
import 'package:elmohadra/features/chapters/domain/repositories/chapter_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChaptersUsecase extends BaseUsecase<List<ChapterEntity>, String> {
  final ChapterRepository chapterRepository;

  GetChaptersUsecase({required this.chapterRepository});

  @override
  Future<Either<Failure, List<ChapterEntity>>> call(String subjectId) =>
      chapterRepository.getChapters(subjectId);
}
