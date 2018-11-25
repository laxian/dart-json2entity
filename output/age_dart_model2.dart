/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
import 'package:json_annotation/json_annotation.dart';

part 'age_dart_model2.g.dart';

@JsonSerializable()
class AgeDartModel2 {
AgeDartModel2({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
  factory AgeDartModel2.fromJson(Map<String, dynamic> json) => _$AgeDartModel2FromJson(json);
  Map<String, dynamic> toJson() => _$AgeDartModel2ToJson(this);
}

@JsonSerializable()
class DataModel {
DataModel({this.age,});
  num age;
  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

