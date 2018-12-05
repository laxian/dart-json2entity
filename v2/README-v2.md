# 用Dart语言实现的json转Dart实体类工具

    不管用什么语言开发，总离不开数据的序列化和反序列化。
    在java中，我习惯了用gson之类的工具，将json字符串反序列化为对象，或者将对象序列换成json字符串。反序列化需要定义实体类，在java中自动生成实体类的工具还是很多的，比如我常用的GsonFormat插件。

    在Flutter中，我也需要一个类似的工具，帮我把可能庞大的，json格式，自动生成对应的实体类。这个project就是做这个事情的，所以叫*flutter-gsonformat*

## Clazz
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


## JsonSerializableClazz
 增加json_serializable的支持

和一般entity的差异：
1. json_serializable 格式的实体类，多了一个注解`@JsonSerializable()`
2. fromJson和toJson方法也有变化
3. 生成后，还需要通过命令生成另一部分
`flutter packages pub run build_runner build`

## Director
配置并输出实体类到文件

## Sample
1. 输入简单json如下：
```json
{
    "result":1,
    "msg":"ok"
}
```
执行`./json2entity -j '{"result":1,"msg":"ok"}' -o output/Abc`
输出如下：
```dart
class Abc {
	num result;
	String msg;
	Abc({
		this.result,
		this.msg
	});

	Abc.fromJson(Map < String, dynamic > json):
		result=json['result'],
		msg=json['msg'];
	Map <String, dynamic> toJson() => {
		'result':result,
		'msg':msg
};
}
```
2. 输入json有嵌套
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
执行`./json2entity -j '{"result":1,"msg":"ok","data":{"answer":"A"}}' -o output/Abc`
输出如下：
```dart
class Abc {
  num result;
  String msg;
  DataEntity data;
  Abc({
    this.result,
    this.msg,
    this.data
  });

  Abc.fromJson(Map < String, dynamic > json):
    result = json['result'],
    msg = json['msg'],
    data = DataEntity.fromJson(json['data']);
  Map < String, dynamic > toJson() => {
    'result': result,
    'msg': msg,
    'data': data.toJson()
  };
}

class DataEntity {
  String answer;
  DataEntity({
    this.answer
  });

  DataEntity.fromJson(Map < String, dynamic > json):
    answer = json['answer'];
  Map < String, dynamic > toJson() => {
    'answer': answer
  };
}
```
3. 嵌套，含有简单数组
```json
{
  "city": "Mumbai",
  "streets": [
    "address1",
    "address2"
  ]
}
```
执行`./json2entity -j '{"city":"Mumbai","streets":["address1","address2"]}' -o output/City`
输出如下：
```dart
class City {
  String city;
  List < String > streets;
  City({
    this.city,
    this.streets
  });

  City.fromJson(Map < String, dynamic > json):
    city = json['city'],
    streets = List < String > .from(json['streets']);
  Map < String, dynamic > toJson() => {
    'city': city,
    'streets': streets
  };
}
```
4. 含有list对象的嵌套
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
执行`./json2entity -j '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}' -o output/Production`
输出：
```dart
class Production {
	num id;
	String name;
	List<ImagesEntity> images;
	Production({
		this.id,
		this.name,
		this.images
	});

	Production.fromJson(Map < String, dynamic > json):
		id=json['id'],
		name=json['name'],
		images=(json['images'] as List).map((l)=>ImagesEntity.fromJson(l)).toList();
	Map <String, dynamic> toJson() => {
		'id':id,
		'name':name,
		'images':images.map((it)=>it.toJson())
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
5. 输入map列表
```json
[
  {
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "http://placehold.it/600/92c952",
    "thumbnailUrl": "http://placehold.it/150/92c952"
  },
  {
    "albumId": 1,
    "id": 2,
    "title": "reprehenderit est deserunt velit ipsam",
    "url": "http://placehold.it/600/771796",
    "thumbnailUrl": "http://placehold.it/150/771796"
  },
  {
    "albumId": 1,
    "id": 3,
    "title": "officia porro iure quia iusto qui ipsa ut modi",
    "url": "http://placehold.it/600/24f355",
    "thumbnailUrl": "http://placehold.it/150/24f355"
  }
]
```
输出：
```dart
class Album {
  List < DatasEntity > datas;
  Album({
    this.datas
  });

  Album.fromJson(Map < String, dynamic > json):
    datas = (json['datas'] as List).map((l) => DatasEntity.fromJson(l)).toList();
  Map < String, dynamic > toJson() => {
    'datas': datas.map((it) => it.toJson())
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
    albumId = json['albumId'],
    id = json['id'],
    title = json['title'],
    url = json['url'],
    thumbnailUrl = json['thumbnailUrl'];
  Map < String, dynamic > toJson() => {
    'albumId': albumId,
    'id': id,
    'title': title,
    'url': url,
    'thumbnailUrl': thumbnailUrl
  };
}
```

部分json用例取自[这里](https://juejin.im/post/5b5d782ae51d45191c7e7fb3#heading-9)