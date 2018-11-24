# 给Dart和flutter的GsonFormat

[English](https://github.com/laxian/flutter-gsonformat/blob/master/README-en.md)

本周入坑flutter，发现竟然Dart语言竟没有json转实体类的工具，就手动写了个简陋的。能用，慢慢改善。

## 功能

-   输入json 字符串，Model名和json定义在input.json，输出实体类。类似Java的GsonFormat
-   支持json_serializable
    执行成功后，执行:
    `flutter packages pub run build_runner build --delete-conflicting-outputs`

## 用法：

* `dart json2bean.dart`
* `dart cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/Age -v`

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
项目根目录运行：
` flutter packages pub run build_runner build`,得到：
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
