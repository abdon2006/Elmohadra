import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';

abstract class ChapterDatasource {
  Future<List<ChapterEntity>> getChapters(String subjectId);
}
