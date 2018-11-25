/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
import 'package:json_annotation/json_annotation.dart';

part 'age_model2.g.dart';

@JsonSerializable()
class AgeModel2 {
AgeModel2({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
  factory AgeModel2.fromJson(Map<String, dynamic> json) => _$AgeModel2FromJson(json);
  Map<String, dynamic> toJson() => _$AgeModel2ToJson(this);
}

@JsonSerializable()
class DataModel {
DataModel({this.age,});
  num age;
  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

