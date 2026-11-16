import 'package:elmohadra/features/chapters/domain/usecases/get_chapters_usecase.dart';
import 'package:elmohadra/features/chapters/presentation/bloc/chapter_event.dart';
import 'package:elmohadra/features/chapters/presentation/bloc/chapter_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChapterBloc extends Bloc<ChapterEvent, ChapterStates> {
  final GetChaptersUsecase getChaptersUsecase;

  ChapterBloc({required this.getChaptersUsecase}) : super(ChapterInitial()) {
    on<GetChaptersEvent>((event, emit) async {
      emit(ChapterLoading());
      final res = await getChaptersUsecase(event.subjectId);
      res.fold(
        (f) => emit(ChapterError(failure: f)),
        (r) => emit(GetChaptersSuccess(chapters: r)),
      );
    });
  }
}
