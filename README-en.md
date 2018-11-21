# Convert json to entity class like GsonFormat for Java

[中文](https://github.com/laxian/flutter-gsonformat/blob/master/README.md)

As a freshman for Flutter, I need a json-to-entity converter for Dart, So I write this poor tool。
It's simple BUT HELPFUL.

## Feature

-   Input json, output entity class file in Dart language.
-   support json_serializable
    U need do this by yourself:`flutter packages pub run build_runner build --delete-conflicting-outputs`

## How to use

* `dart json2bean.dart`
* `dart cli.dart -j '{"age":18, "name": "zhouweixian"}' -o
Age`


## Sample
input:
```
{
  "result": 1,
  "msg": "ok",
  "data": {
    "forceType": 1,
    "title": "update found",
    "message": "please update",
    "url": "www.baidu.com"
  }
}
```
output:
```
// app_update_check.dart
import 'package:json_annotation/json_annotation.dart';

part 'app_update_check.g.dart';

/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
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
```
then run command in project root path:
` flutter packages pub run build_runner build`,
you will get below:
```
// app_update_check.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateCheck _$AppUpdateCheckFromJson(Map<String, dynamic> json) {
  return AppUpdateCheck(
      result: json['result'] as num,
      msg: json['msg'] as String,
      data: json['data'] == null
          ? null
          : DataModel.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AppUpdateCheckToJson(AppUpdateCheck instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'data': instance.data
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
      forceType: json['forceType'] as num,
      title: json['title'] as String,
      message: json['message'] as String,
      url: json['url'] as String);
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'forceType': instance.forceType,
      'title': instance.title,
      'message': instance.message,
      'url': instance.url
};

```
