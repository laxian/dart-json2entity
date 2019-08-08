# json2entity

<p align="left">
  <a href="https://pub.dartlang.org/packages/json2entity"><img alt="pub version" src="https://img.shields.io/pub/v/json2entity.svg"></a>
</p>

[中文](https://github.com/laxian/dart-json2entity/blob/master/README-cn.md)

A tool for converting JSON strings into dart entity classes

support [json_serializable](https://pub.dartlang.org/packages/json_serializable).

[无需手写，自动生成Flutter/Dart实体类文件 -- 掘金](https://juejin.im/post/5c36251ce51d45524473f79f)

## Usage

Firstly:
```yaml
dependencies:
  json2entity: ^1.0.8
```

1. activate json2entity global.

`pub global activate json2entity`

2. run anywhere:

`json2entity -j '{"result":1,"msg":"ok"}' -o output/BaseEntity`

or

`j2e -j '{"result":1,"msg":"ok"}' -o output/BaseEntity`


SYNOPSIS:
```shell
Usage:
        -j, --json                              Input json string
        -f, --file                              Input json from file
        -o, --output                            Input output file path and name
        -v, --[no-]verbose                      Show verbose
        -s, --[no-]json-serializable-support    Indicates whether json-serializable is supported
        -h, --[no-]help                         Help
```


#### Custom


```dart
import 'package:json2entity/json2entity.dart';

main(List<String> args) {
  var jsonStr = '{"result":1,"msg":"ok"}';
  print(Clazz.fromJson(jsonStr).toString()); 
  print(JsonSerializableClazz.fromJson(jsonStr).toString()); 
}
```

Output:
```
  class AutoModel {
    num result;
    String msg;
    AutoModel({
    this.result,
    this.msg
    });

    AutoModel.fromJson(Map < String, dynamic > json):
      result=json['result'],
      msg=json['msg'];
      Map <String, dynamic> toJson() => {
      'result':result,
      'msg':msg
    };
  }

  @JsonSerializable()
  class AutoModel {
    num result;
      String msg;
      AutoModel({
      this.result,
      this.msg
    });

    factory AutoModel.fromJson(Map<String, dynamic> json) => _$AutoModelFromJson(json);
      Map<String, dynamic> toJson() => _$AutoModelToJson(this);
    }
```

## Main classes
#### Clazz
  Converting JSON strings into entity classes.

#### JsonSerializableClazz
  Inheriting from Clazz, transforming JSON strings into entity classes that support json_serializable

## Example
[wiki](https://github.com/laxian/dart-json2entity/wiki#example)

## Test
`./test_all.sh`