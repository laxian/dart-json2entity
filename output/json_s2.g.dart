// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_s2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonS2 _$JsonS2FromJson(Map<String, dynamic> json) {
  return JsonS2(
      result: json['result'] as num,
      msg: json['msg'] as String,
      data: json['data'] == null
          ? null
          : DataEntity.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$JsonS2ToJson(JsonS2 instance) => <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'data': instance.data
    };

DataEntity _$DataEntityFromJson(Map<String, dynamic> json) {
  return DataEntity(answer: json['answer'] as String);
}

Map<String, dynamic> _$DataEntityToJson(DataEntity instance) =>
    <String, dynamic>{'answer': instance.answer};
