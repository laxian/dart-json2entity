// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_s5.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonS5 _$JsonS5FromJson(Map<String, dynamic> json) {
  return JsonS5(
      datas: (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : DatasEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$JsonS5ToJson(JsonS5 instance) =>
    <String, dynamic>{'datas': instance.datas};

DatasEntity _$DatasEntityFromJson(Map<String, dynamic> json) {
  return DatasEntity(
      albumId: json['albumId'] as num,
      id: json['id'] as num,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String);
}

Map<String, dynamic> _$DatasEntityToJson(DatasEntity instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl
    };
