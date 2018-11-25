# Flutter 框架下的json转实体类工具

[English](https://github.com/laxian/flutter-gsonformat/blob/master/README-en.md)

> 本周入坑flutter，发现竟然Dart语言竟没有json转实体类的工具，就手动写了个简陋的。能用，慢慢改善。


## 功能

-   输入json 字符串，输出实体类。类似Android Studio的GsonFormat工具

- 使用dart语言开发

- 支持命令行工具

- 支持从文件批量读入json并转换

- 可以生成支持[json_serializable](https://pub.dartlang.org/packages/json_serializable)的实体类(可选)

- 暂不支持继承

对flutter的json 序列化不了解的，建议先阅读[官方文档](https://flutter.io/docs/development/data-and-backend/json)

## 用法：

参考：[test_cli.sh](https://github.com/laxian/flutter-gsonformat/blob/master/test_cli.sh)

- shell
  * ./json2entity -j <json_string> -o <output_path> [-v] [--support-json-serializable]
  `./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/AgeModel -v`
  * ./json2entity -f <input_file_of_jsons> -o <output_path> [-v] [--support-json-serializable]
  `./json2entity -f ./input/input.json -o output/ --support-json-serializable`

- dart
  * dart ./cli.dart -j <json_string> -o <output_path> [-v] [--support-json-serializable]
  `dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/AgeModel -v`
  * dart ./cli.dart -f <input_file_of_jsons> -o <output_path> [-v] [--support-json-serializable]
  `dart ./cli.dart -f ./input/input.json -o output/ --support-json-serializable`

## 高级用法

使用dart代码调用，参考
[sample.dart](https://github.com/laxian/flutter-gsonformat/blob/master/sample.dart)
[sample2.dart](https://github.com/laxian/flutter-gsonformat/blob/master/sample2.dart)

```
/// test_convert.dart
import 'entity_writer_builder.dart';

main(List < String > args) {
  var jsonStr = '{"result":1,"msg":"success","data":{"age":18}}';
  var outName = 'AgeModel';
  new EntityWriterBuilder()
    .supportJsonSerializable(false)
    .name(outName)
    .jsonStr(jsonStr)
    .outpath('output/')
    .build()
    .convert();
}
```

## Sample
input:
```
{
  "result": 1,
  "msg": "ok",
  "data": {
    "age": 18
  }
}
```
output:
```
/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
class AgeModel {
  AgeModel({
    this.result,
    this.msg,
    this.data,
  });
  num result;
  String msg;
  DataModel data;
  AgeModel.fromJson(Map < String, dynamic > json):
    result = json['result'],
    msg = json['msg'],
    data = json['data'];
  Map < String, dynamic > toJson() => {
    'result': result,
    'msg': msg,
    'data': data
  };
}

class DataModel {
  DataModel({
    this.age,
  });
  num age;
  DataModel.fromJson(Map < String, dynamic > json):
    age = json['age'];
  Map < String, dynamic > toJson() => {
    'age': age
  };
}
```

如果开启了json_serializable支持，结果是这样滴：
```
/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
import 'package:json_annotation/json_annotation.dart';

part 'age_model.g.dart';

@JsonSerializable()
class AgeModel {
AgeModel({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
  factory AgeModel.fromJson(Map<String, dynamic> json) => _$AgeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgeModelToJson(this);
}

@JsonSerializable()
class DataModel {
DataModel({this.age,});
  num age;
  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
```

保证上面的输出文件在flutter项目，且正确配置了json_seriablizable，并且手动运行

`flutter packages pub run build_runner build`
，自动生成下面的文件：
```
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgeModel _$AgeModelFromJson(Map<String, dynamic> json) {
  return AgeModel(
      result: json['result'] as num,
      msg: json['msg'] as String,
      data: json['data'] == null
          ? null
          : DataModel.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AgeModelToJson(AgeModel instance) => <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'data': instance.data
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(age: json['age'] as num);
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) =>
    <String, dynamic>{'age': instance.age};

```
