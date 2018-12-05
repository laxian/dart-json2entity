import 'package:json_annotation/json_annotation.dart';
part 'myage.g.dart';

@JsonSerializable()
class AutoModel {
num result;
String msg;
DataEntity data;
AutoModel({
this.result,this.msg,this.data
});

factory AutoModel.fromJson(Map<String, dynamic> json) => _$AutoModelFromJson(json);
Map<String, dynamic> toJson() => _$AutoModelToJson(this);
}

@JsonSerializable()
class DataEntity {
num age;
DataEntity({
this.age
});

factory DataEntity.fromJson(Map<String, dynamic> json) => _$DataEntityFromJson(json);
Map<String, dynamic> toJson() => _$DataEntityToJson(this);
}