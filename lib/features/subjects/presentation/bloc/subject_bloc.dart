import 'package:elmohadra/features/subjects/domain/usecases/get_subjects_usecase.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_event.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubjectBloc extends Bloc<SubjectEvents, SubjectStates> {
  final GetSubjectsUsecase getSubjectsUsecase;

  SubjectBloc({required this.getSubjectsUsecase}) : super(SubjectInitial()) {
    on<GetSubjectsEvent>((event, emit) async {
      emit(SubjectLoading());

      final res = await getSubjectsUsecase(event.academicYear);
      res.fold(
        (l) => emit(SubjectError(failure: l)),
        (r) => emit(SubjectsLoaded(subjects: r)),
      );
    });
  }
}
