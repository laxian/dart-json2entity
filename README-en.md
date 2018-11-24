# Convert json to entity class like GsonFormat for Java

[中文](https://github.com/laxian/flutter-gsonformat/blob/master/README.md)

As a freshman for Flutter, I need a json-to-entity converter for Dart, So I write this poor tool。
It's simple BUT HELPFUL.

See [flutter docs](https://flutter.io/docs/development/data-and-backend/json). If you know little about json serialization with flutter

Convert json to entity class file. supporting[json_serializable](https://pub.dartlang.org/packages/json_serializable)(optional)

## How to use

* `dart json2bean.dart`
* `dart cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/AgeModel`
* `dart cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/AgeModel -v --support-json-serializable`

## Advanced
[sample.dart](https://github.com/laxian/flutter-gsonformat/blob/master/sample.dart)
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

if support json_serializable, you will get below:
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

Ensure you output file above in flutter project. and you have run command:
`flutter packages pub run build_runner build`. Then you will get:
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
