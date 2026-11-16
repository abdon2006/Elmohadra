import 'package:equatable/equatable.dart';

abstract class ChapterEvent extends Equatable {}

class GetChaptersEvent extends ChapterEvent {
  final String subjectId;

  GetChaptersEvent({required this.subjectId});

  @override
  List<Object?> get props => [subjectId];
}
