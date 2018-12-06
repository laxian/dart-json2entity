// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_s6.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonS6 _$JsonS6FromJson(Map<String, dynamic> json) {
  return JsonS6(
      message: json['message'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : DataEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$JsonS6ToJson(JsonS6 instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

DataEntity _$DataEntityFromJson(Map<String, dynamic> json) {
  return DataEntity(
      title: json['title'] as String,
      gallary_flag: json['gallary_flag'] as num,
      image_list: (json['image_list'] as List)
          ?.map((e) => e == null
              ? null
              : Image_listEntity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      article_url: json['article_url'] as String,
      cover_image_url: json['cover_image_url'] as String,
      gallery_image_count: json['gallery_image_count'] as num);
}

Map<String, dynamic> _$DataEntityToJson(DataEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'gallary_flag': instance.gallary_flag,
      'image_list': instance.image_list,
      'article_url': instance.article_url,
      'cover_image_url': instance.cover_image_url,
      'gallery_image_count': instance.gallery_image_count
    };

Image_listEntity _$Image_listEntityFromJson(Map<String, dynamic> json) {
  return Image_listEntity(url: json['url'] as String);
}

Map<String, dynamic> _$Image_listEntityToJson(Image_listEntity instance) =>
    <String, dynamic>{'url': instance.url};
