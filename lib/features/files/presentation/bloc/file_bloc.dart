import 'package:elmohadra/features/files/domain/usecases/get_chapter_details_usecase.dart';
import 'package:elmohadra/features/files/presentation/bloc/file_event.dart';
import 'package:elmohadra/features/files/presentation/bloc/file_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FileBloc extends Bloc<FileEvent, FileStates> {
  final GetChapterDetailsUsecase getChapterDetailsUsecase;

  FileBloc({required this.getChapterDetailsUsecase}) : super(FileInitial()) {
    on<GetFilesEvent>((event, emit) async {
      emit(FileLoading());
      final res = await getChapterDetailsUsecase(event.chapterId);
      res.fold(
        (f) => emit(FileError(failure: f)),
        (r) => emit(GetFilesSuccess(chapterDetailsEntity: r)),
      );
    });
  }
}
