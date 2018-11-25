# A tool that convert json to Entitiy class file

[中文](https://github.com/laxian/flutter-gsonformat/blob/master/README.md)

As a freshman for Flutter, I need a json-to-entity converter for Dart, So I write this poor tool。
It's simple BUT HELPFUL.


## Feature

-   input *json* string，output *entity class file*。Like the plugin *GsonFormat* of Android Studio

- Write in dart lang

- support cli

- support read jsons from file and convert

- support [json_serializable](https://pub.dartlang.org/packages/json_serializable)(optional)

- not support inherit now

See [flutter-doc#json](https://flutter.io/docs/development/data-and-backend/json) first if you know little about json serialization in flutter

## HOW-TO

See: [test_cli.sh](https://github.com/laxian/flutter-gsonformat/blob/master/test_cli.sh)

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

## Advanced

Invoke in your dart source code. Like in
[sample.dart](https://github.com/laxian/flutter-gsonformat/blob/master/sample.dart)
[sample2.dart](https://github.com/laxian/flutter-gsonformat/blob/master/sample2.dart)

```dart
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
```dart
{
  "result": 1,
  "msg": "ok",
  "data": {
    "age": 18
  }
}
```
output:
```dart
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

If you enabled json_serializable, you'll get the following file
```dart
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

Make sure you have json_seriablizable package installed.
Then run in terminal:

`flutter packages pub run build_runner build`
And then got:
```dart
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
