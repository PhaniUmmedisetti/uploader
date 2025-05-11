// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedFile _$UploadedFileFromJson(Map<String, dynamic> json) => UploadedFile(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$UploadedFileToJson(UploadedFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'created_at': instance.createdAt.toIso8601String(),
      'lat': instance.lat,
      'long': instance.long,
    };
