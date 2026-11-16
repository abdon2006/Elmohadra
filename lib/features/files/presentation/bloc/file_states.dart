import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/features/files/domain/entities/chapter_details_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FileStates extends Equatable {}

class FileInitial extends FileStates {
  @override
  List<Object?> get props => [];
}

class FileLoading extends FileStates {
  @override
  List<Object?> get props => [];
}

class FileError extends FileStates {
  final Failure failure;

  FileError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class GetFilesSuccess extends FileStates {
  final ChapterDetailsEntity chapterDetailsEntity;

  GetFilesSuccess({required this.chapterDetailsEntity});

  @override
  List<Object?> get props => [chapterDetailsEntity];
}
