/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
import 'package:json_annotation/json_annotation.dart';

part 'myage.g.dart';

@JsonSerializable()
class Myage {
Myage({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
  factory Myage.fromJson(Map<String, dynamic> json) => _$MyageFromJson(json);
  Map<String, dynamic> toJson() => _$MyageToJson(this);
}

@JsonSerializable()
class DataModel {
DataModel({this.age,});
  num age;
  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

