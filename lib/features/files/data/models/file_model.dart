import 'package:elmohadra/features/files/domain/entities/file_entity.dart';

class FileModel extends FileEntity {
  const FileModel({required super.id, required super.title});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as String,
      title: json['file_title'] as String,
    );
  }
}
