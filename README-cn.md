# json2entity

<p align="left">
  <a href="https://pub.dartlang.org/packages/json2entity"><img alt="pub version" src="https://img.shields.io/pub/v/json2entity.svg"></a>
</p>

[English](https://github.com/laxian/dart-json2entity/blob/master/README.md)

Dart语言的，JSON转实体类源码工具。
支持生成使用[json_serializable](https://pub.dartlang.org/packages/json_serializable)的实体类。

[无需手写，自动生成Flutter/Dart实体类文件 -- 掘金](https://juejin.im/post/5c36251ce51d45524473f79f)

## Usage

- 1. 添加依赖
```yaml
dependencies:
  json2entity: ^1.0.9
```

- 2. 激活命令

```shell
pub global activate json2entity
```

- 3. 最后，在任意目录执行命令：

```shell
# 输出到标准输出
j2e -j '{"result":1,"msg":"ok"}'

# 输出到文件
j2e -j '{"result":1,"msg":"ok"}' -o output/BaseEntity
```
### **Windows** 用户
对于**Windows**用户，如果你使用CMD或者powershell，你可能需要先转义JSON字符串：

`j2e -j '{\"result\":1,\"msg\":\"ok\"}' -o output/BaseEntity`

SYNOPSIS:
```shell
$ j2e -h
Usage:
        -j, --json                              Input json string
        -f, --file                              Input json from file
        -o, --output                            Input output file path and name
        -v, --[no-]verbose                      Show verbose
        -s, --[no-]json-serializable-support    Indicates whether json-serializable is supported
        -h, --[no-]help                         Help
```

#### 代码方式

`import 'package:json2entity/json2entity.dart';`

```dart
main(List<String> args) {
  var jsonStr = '{"result":1,"msg":"ok"}';
  print(Clazz.fromJson(jsonStr).toString()); // ==>
  /*
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
  */
  print(JsonSerializableClazz.fromJson(jsonStr).toString()); // ==>
  /*
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
  */
}

```

## Main classes
#### Clazz
  转换json为实体类，标准实现。

  转换步骤：
1. 解析json结构
      - json -> map
	  - 对map进行压缩（新增，后文详述）
      - 遍历map树，建立实体类依赖图
2. 组合实体类
      1. file header      文件头部，import、part、part of等语句，可选
      2. decorator        注解、装饰器，可选
      3. class declare    类声明，class xxx {
      4. fields           类成员变量
      5. constructor      构造函数
      6. fromJson method  fromJson方法
      7. toJson method    toJson方法
      8. 拼接1-6步，合成class
      9. 递归1-7，合成children

> 上面说到对map压缩，主要针对map中的List，将list中的所有项，合并成一个。如：'[{"k1":1, "k2":0},  {"k2": 0, "k3": true}]' 合并成：[{"k1":1, "k2":0, "k3":true}]


#### JsonSerializableClazz
 继承Clazz，增加对[json_serializable](https://pub.dartlang.org/packages/json_serializable)的支持。

 使用json_serializable和不使用json_serializable的实体类的差异：
  1. 多了一个part `'xxx.dart'` 的头部header
  2. 多了一个注解`@JsonSerializable()`
  3. fromJson、toJson方法不一样
  4. 生成后，还需要通过命令生成另一部分
  `flutter packages pub run build_runner build`

#### Director
配置并输出实体类到文件

## Example
[wiki](https://github.com/laxian/dart-json2entity/wiki#example)

## 测试
`./test_all.sh`