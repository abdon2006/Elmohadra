import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';

abstract class FileDatasource {
  Future<ChapterDetailsEntity> getChapterDetails(String chapterId);
}
