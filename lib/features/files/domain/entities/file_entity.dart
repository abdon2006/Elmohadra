import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String id;
  final String title;

  const FileEntity({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
