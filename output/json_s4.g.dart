// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_s4.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonS4 _$JsonS4FromJson(Map<String, dynamic> json) {
  return JsonS4(
      id: json['id'] as num,
      name: json['name'] as String,
      images: (json['images'] as List)
          ?.map((e) => e == null
              ? null
              : ImagesEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$JsonS4ToJson(JsonS4 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images
    };

ImagesEntity _$ImagesEntityFromJson(Map<String, dynamic> json) {
  return ImagesEntity(
      id: json['id'] as num, imageName: json['imageName'] as String);
}

Map<String, dynamic> _$ImagesEntityToJson(ImagesEntity instance) =>
    <String, dynamic>{'id': instance.id, 'imageName': instance.imageName};
