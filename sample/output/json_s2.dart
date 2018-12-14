import 'package:json_annotation/json_annotation.dart';
part 'json_s2.g.dart';

@JsonSerializable()
class JsonS2 {
  num result;
  String msg;
  DataEntity data;
  JsonS2({this.result, this.msg, this.data});

  factory JsonS2.fromJson(Map<String, dynamic> json) => _$JsonS2FromJson(json);
  Map<String, dynamic> toJson() => _$JsonS2ToJson(this);
}

@JsonSerializable()
class DataEntity {
  String answer;
  DataEntity({this.answer});

  factory DataEntity.fromJson(Map<String, dynamic> json) =>
      _$DataEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DataEntityToJson(this);
}
