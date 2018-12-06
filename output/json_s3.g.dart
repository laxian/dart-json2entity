// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_s3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonS3 _$JsonS3FromJson(Map<String, dynamic> json) {
  return JsonS3(
      city: json['city'] as String,
      streets: (json['streets'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$JsonS3ToJson(JsonS3 instance) =>
    <String, dynamic>{'city': instance.city, 'streets': instance.streets};
