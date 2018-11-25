/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
import 'package:json_annotation/json_annotation.dart';

part 'app_update_check.g.dart';

@JsonSerializable()
class AppUpdateCheck {
AppUpdateCheck({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
  factory AppUpdateCheck.fromJson(Map<String, dynamic> json) => _$AppUpdateCheckFromJson(json);
  Map<String, dynamic> toJson() => _$AppUpdateCheckToJson(this);
}

@JsonSerializable()
class DataModel {
DataModel({this.forceType,this.title,this.message,this.url,});
  num forceType;
  String title;
  String message;
  String url;
  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

