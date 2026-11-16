import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/chapters/domain/entities/chapter_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChapterStates extends Equatable {}

class ChapterInitial extends ChapterStates {
  @override
  List<Object?> get props => [];
}

class ChapterLoading extends ChapterStates {
  @override
  List<Object?> get props => [];
}

class ChapterError extends ChapterStates {
  final Failure failure;

  ChapterError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class GetChaptersSuccess extends ChapterStates {
  final List<ChapterEntity> chapters;

  GetChaptersSuccess({required this.chapters});

  @override
  List<Object?> get props => [chapters];
}
