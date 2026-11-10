import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/subjects/domain/entities/subject_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SubjectStates extends Equatable {}

class SubjectInitial extends SubjectStates {
  @override
  List<Object?> get props => [];
}

class SubjectLoading extends SubjectStates {
  @override
  List<Object?> get props => [];
}

class SubjectError extends SubjectStates {
  final Failure failure;

  SubjectError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class SubjectsLoaded extends SubjectStates {
  final List<SubjectEntity> subjects;

  SubjectsLoaded({required this.subjects});

  @override
  List<Object?> get props => [subjects];
}
