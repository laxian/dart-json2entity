import 'package:json_annotation/json_annotation.dart';

part 'age.g.dart';

/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
@JsonSerializable()
class Age {
Age({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
  factory Age.fromJson(Map<String, dynamic> json) => _$AgeFromJson(json);
  Map<String, dynamic> toJson() => _$AgeToJson(this);
}

@JsonSerializable()
class DataModel {
DataModel({this.status,});
  num status;
  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

