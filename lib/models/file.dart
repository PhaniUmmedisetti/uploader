import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class UploadedFile {
  final String id;
  final String name;
  final String url;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final double lat;
  final double long;

  UploadedFile({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.lat,
    required this.long,
  });

  factory UploadedFile.fromJson(Map<String, dynamic> json) =>
      _$UploadedFileFromJson(json);

  Map<String, dynamic> toJson() => _$UploadedFileToJson(this);
}