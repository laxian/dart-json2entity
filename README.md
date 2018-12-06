# 用Dart语言实现的json转Dart实体类工具

不管用什么语言开发，总离不开数据的序列化和反序列化。
在java中，我习惯了用gson、fastjson之类的工具，将json字符串反序列化为对象，
或者将对象序列换成json字符串。

反序列化为实体类需要先编写好实体类，在java中根据json自动生成实体类的工具很多，比如我常用的GsonFormat插件。

在Flutter中，我也需要一个类似的工具，帮我根据json字符串自动生成对应的实体类。这个项目就是做这个事情的，所以叫**flutter-gsonformat**

v1 已废弃，当前v2

## 使用

#### 代码方式 - Dart
  - Clazz.fromJson(jsonStr).toString();
  - JsonSerializableClazz.fromJson(jsonStr).toString();

#### 命令行方式
`./json2entity -j '{"result":1,"msg":"ok"}' -o output/BaseEntity`

## 实现
#### Clazz
  基本转换。
  转换分解成以下步骤：

    0. file header      文件头部，import、part、part of等语句，可选
    1. decorator        注解、装饰器，可选
    2. class declare    类声明，class xxx {
    3. fields           类成员变量
    4. constructor      构造函数
    5. fromJson method  fromJson方法
    6. toJson method    toJson方法
    7. 拼接1-6步，合成class
    8. 递归1-7，合成children
    9. 输出


#### JsonSerializableClazz
 继承Clazz，增加对[json_serializable](https://pub.dartlang.org/packages/json_serializable)的支持。

 支持json_serializable和不使用json_serializable的实体类的差异：
  1. 多了一个part `'xxx.dart'` 的头部header
  2. 多了一个注解`@JsonSerializable()`
  3. fromJson、toJson方法不一样
  4. 生成后，还需要通过命令生成另一部分
  `flutter packages pub run build_runner build`

#### Director
配置并输出实体类到文件

## Sample
1. 输入简单json如下：
```json
{
    "result":1,
    "msg":"ok"
}
```
执行`./json2entity -j '{"result":1,"msg":"ok"}' -o output/Json1`
输出如下：
```dart
class Json1 {
	num result;
	String msg;
	Json1({
		this.result,
		this.msg
	});

	Json1.fromJson(Map < String, dynamic > json):
		result=json['result'],
		msg=json['msg'];
	Map <String, dynamic> toJson() => {
		'result':result,
		'msg':msg
	};
}
```
2. 输入嵌套json
```json
{
    "result":1,
    "msg":"ok",
    "data":
    {
        "answer":"A"
    }
}
```
执行`./json2entity -j '{"result":1,"msg":"ok","data":{"answer":"A"}}' -o output/Json2`
输出如下：
```dart
class Json2 {
	num result;
	String msg;
	DataEntity data;
	Json2({
		this.result,
		this.msg,
		this.data
	});

	Json2.fromJson(Map < String, dynamic > json):
		result=json['result'],
		msg=json['msg'],
		data=DataEntity.fromJson(json['data']);
	Map <String, dynamic> toJson() => {
		'result':result,
		'msg':msg,
		'data':data.toJson()
	};
}

class DataEntity {
	String answer;
	DataEntity({
		this.answer
	});

	DataEntity.fromJson(Map < String, dynamic > json):
		answer=json['answer'];
	Map <String, dynamic> toJson() => {
		'answer':answer
	};
}
```
3. 输入json，嵌套简单list
```json
{
  "city": "Mumbai",
  "streets": [
    "address1",
    "address2"
  ]
}
```
执行`./json2entity -j '{"city":"Mumbai","streets":["address1","address2"]}' -o output/Json3`
输出如下：
```dart
class Json3 {
	String city;
	List<String> streets;
	Json3({
		this.city,
		this.streets
	});

	Json3.fromJson(Map < String, dynamic > json):
		city=json['city'],
		streets=List<String>.from(json['streets']);
	Map <String, dynamic> toJson() => {
		'city':city,
		'streets':streets
	};
}
```
4. 输入json，嵌套对象list
```json
{
  "id":1,
  "name":"ProductName",
  "images":[
    {
      "id":11,
      "imageName":"xCh-rhy"
    },
    {
      "id":31,
      "imageName":"fjs-eun"
    }
  ]
}
```
执行`./json2entity -j '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}' -o output/Json4`
输出：
```dart
class Json4 {
	num id;
	String name;
	List<ImagesEntity> images;
	Json4({
		this.id,
		this.name,
		this.images
	});

	Json4.fromJson(Map < String, dynamic > json):
		id=json['id'],
		name=json['name'],
		images=(json['images'] as List).map((l)=>ImagesEntity.fromJson(l)).toList();
	Map <String, dynamic> toJson() => {
		'id':id,
		'name':name,
		'images':images.map((it)=>it.toJson()).toList()
	};
}

class ImagesEntity {
	num id;
	String imageName;
	ImagesEntity({
		this.id,
		this.imageName
	});

	ImagesEntity.fromJson(Map < String, dynamic > json):
		id=json['id'],
		imageName=json['imageName'];
	Map <String, dynamic> toJson() => {
		'id':id,
		'imageName':imageName
	};
}
```
5. 输入map列表。这个需要强调一下，我的方法是，将[...]转化成{"datas": [...]}，之后再转换
```json
[
  {
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "http://placehold.it/600/92c952",
    "thumbnailUrl": "http://placehold.it/150/92c952"
  }
]
```
执行`./json2entity -j '[{"albumId":1,"id":1,"title":"accusamus","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]' -o output/Json5`
输出：
```dart
class Json5 {
	List<DatasEntity> datas;
	Json5({
		this.datas
	});

	Json5.fromJson(Map < String, dynamic > json):
		datas=(json['datas'] as List).map((l)=>DatasEntity.fromJson(l)).toList();
	Map <String, dynamic> toJson() => {
		'datas':datas.map((it)=>it.toJson()).toList()
	};
}

class DatasEntity {
	num albumId;
	num id;
	String title;
	String url;
	String thumbnailUrl;
	DatasEntity({
		this.albumId,
		this.id,
		this.title,
		this.url,
		this.thumbnailUrl
	});

	DatasEntity.fromJson(Map < String, dynamic > json):
		albumId=json['albumId'],
		id=json['id'],
		title=json['title'],
		url=json['url'],
		thumbnailUrl=json['thumbnailUrl'];
	Map <String, dynamic> toJson() => {
		'albumId':albumId,
		'id':id,
		'title':title,
		'url':url,
		'thumbnailUrl':thumbnailUrl
	};
}
```

## 测试

```shell
# 生成实体类
./test_cli.sh
# 测试实体类-json互转
dart test_entity.dart
```

```bash
#!/bin/sh

set -e

# // 5种不同类型json测试用例，分别是
# // 简单无嵌套json
# // 嵌套json
# // 嵌套简单列表json
# // 嵌套对象列表json
# // 对象列表json
json1='{"result":1,"msg":"ok"}';
json2='{"result":1,"msg":"ok","data":{"answer":"A"}}';
json3='{"city":"Mumbai","streets":["address1","address2"]}';
json4='{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
json5='[{"albumId":1,"id":1,"title":"accusamus","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]';

# 和上面5中用例一样
inputFile=./input/input.json

# normal
./json2entity -j $json1 --output ./output/Json1
./json2entity -j $json2 --output ./output/Json2
./json2entity -j $json3 --output ./output/Json3
./json2entity -j $json4 --output ./output/Json4
./json2entity -j $json5 --output ./output/Json5

# json_serializable support
./json2entity -j $json1 --output ./output/JsonS1 -s
./json2entity -j $json2 --output ./output/JsonS2 -s
./json2entity -j $json3 --output ./output/JsonS3 -s
./json2entity -j $json4 --output ./output/JsonS4 -s
./json2entity -j $json5 --output ./output/JsonS5 -s

# input from file
./json2entity -f $inputFile --output ./output/
# ./json2entity -f $inputFile --output ./output/ -s

```
执行完毕，前往output查看。发现生成完毕
```bash
➜  output git:(master) ✗ ls
json1.dart   json3.dart   json5.dart   json_f2.dart json_f4.dart json_s1.dart json_s3.dart json_s5.dart
json2.dart   json4.dart   json_f1.dart json_f3.dart json_f5.dart json_s2.dart json_s4.dart
```
接下来，测试这些生成的实体类，将字符串反序列化
```dart
import 'dart:convert';
import 'output/json1.dart';
import 'output/json2.dart';
import 'output/json3.dart';
import 'output/json4.dart';
import 'output/json5.dart';
import 'output/json_f1.dart';
import 'output/json_f2.dart';
import 'output/json_f3.dart';
import 'output/json_f4.dart';
import 'output/json_f5.dart';
import 'output/json_s1.dart';
import 'output/json_s2.dart';
import 'output/json_s3.dart';
import 'output/json_s4.dart';
import 'output/json_s5.dart';


var json1 = '{"result":1,"msg":"ok"}';
var json2 = '{"result":1,"msg":"ok","data":{"answer":"A"}}';
var json3 = '{"city":"Mumbai","streets":["address1","address2"]}';
var json4 = '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
var json5 = '[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]';

main(List < String > args) {

  print('测试命令行转换的普通实体类');
  testEntityConvertedByCli();
  print('\n测试文件批量转换的普通实体类');
  testEntityConvertedFromFile();
  print('\n测试支持json_serializable的实体类');
  testEntityConvertedSupportJsonSerializable();

  print('\n\nWELL DONE! ALL OUTPUT ENTITY TEST SUCCESSFUL!!\n\n');
}

void testEntityConvertedByCli() {
  
  var j1 = Json1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);
  print(jsonEncode(j1.toJson()));
  
  var j2 = Json2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');
  print(jsonEncode(j2.toJson()));
  
  var j3 = Json3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');
  print(jsonEncode(j3.toJson()));
  
  var j4 = Json4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);
  print(jsonEncode(j4.toJson()));
  
  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas": [...]}
  var list = jsonDecode(json5);
  var j5 = Json5.fromJson({'datas': list});
  assertTrue(j5.datas.length == 1);
  print(jsonEncode(j5.toJson()));
}

void testEntityConvertedSupportJsonSerializable() {
  
  var j1 = JsonS1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);
  print(jsonEncode(j1.toJson()));
  
  var j2 = JsonS2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');
  print(jsonEncode(j2.toJson()));
  
  var j3 = JsonS3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');
  print(jsonEncode(j3.toJson()));
  
  var j4 = JsonS4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);
  print(jsonEncode(j4.toJson()));
  
  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas": [...]}
  var list = jsonDecode(json5);
  var j5 = JsonS5.fromJson({'datas': list});
  assertTrue(j5.datas.length == 1);
  print(jsonEncode(j5.toJson()));
}


void testEntityConvertedFromFile() {
  
  var j1 = JsonF1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);
  print(jsonEncode(j1.toJson()));
  
  var j2 = JsonF2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');
  print(jsonEncode(j2.toJson()));
  
  var j3 = JsonF3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');
  print(jsonEncode(j3.toJson()));
  
  var j4 = JsonF4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);
  print(jsonEncode(j4.toJson()));
  
  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas": [...]}
  var list = jsonDecode(json5);
  var j5 = JsonF5.fromJson({'datas': list});
  assertTrue(j5.datas.length == 1);
  print(jsonEncode(j5.toJson()));
}


void assertTrue(bool b, {String err}) {
  if (!b) {
    throw Exception(err ?? 'assert err!!!');
  }
}
```
执行`dart test_entity.dart`
```shell
[Running] dart "/Users/etiantian/Work/aixue40/flutter-gsonformat/test_entity.dart"
测试命令行转换的普通实体类
{"result":1,"msg":"ok"}
{"result":1,"msg":"ok","data":{"answer":"A"}}
{"city":"Mumbai","streets":["address1","address2"]}
{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}
{"datas":[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]}

测试文件批量转换的普通实体类
{"result":1,"msg":"ok"}
{"result":1,"msg":"ok","data":{"answer":"A"}}
{"city":"Mumbai","streets":["address1","address2"]}
{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}
{"datas":[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]}

测试支持json_serializable的实体类
{"result":1,"msg":"ok"}
{"result":1,"msg":"ok","data":{"answer":"A"}}
{"city":"Mumbai","streets":["address1","address2"]}
{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}
{"datas":[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]}


WELL DONE! ALL OUTPUT ENTITY TEST SUCCESSFUL!!



[Done] exited with code=0 in 2.572 seconds
```

部分json用例取自[这里](https://juejin.im/post/5b5d782ae51d45191c7e7fb3#heading-9)
