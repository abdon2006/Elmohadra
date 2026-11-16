import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';
import 'package:elmohadra/features/files/domain/repositories/file_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChapterDetailsUsecase
    extends BaseUsecase<ChapterDetailsEntity, String> {
  final FileRepository fileRepository;

  GetChapterDetailsUsecase({required this.fileRepository});

  @override
  Future<Either<Failure, ChapterDetailsEntity>> call(String chapterId) =>
      fileRepository.getChapterDetails(chapterId);
}
