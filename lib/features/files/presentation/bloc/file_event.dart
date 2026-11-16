abstract class FileEvent {}

class GetFilesEvent extends FileEvent {
  final String chapterId;

  GetFilesEvent({required this.chapterId});
}
