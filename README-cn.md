# json2entity

<p align="left">
  <a href="https://pub.dartlang.org/packages/json2entity"><img alt="pub version" src="https://img.shields.io/pub/v/json2entity.svg"></a>
</p>

适用于Dart语言的，根据json字符串自动生成对应实体类文件的工具。

这个工具同样支持生成使用[json_serializable](https://pub.dartlang.org/packages/json_serializable)的实体类。

[English](https://github.com/laxian/dart-json2entity/blob/master/README.md)

## Usage

#### pub方式

首先，激活命令

`pub global activate json2entity`

然后，在任意目录执行命令：

`json2entity -j '{"result":1,"msg":"ok"}' -o output/BaseEntity`

或者

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
#### 1. 输入简单json如下：
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
#### 2. 输入嵌套json
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
		'data':data?.toJson()
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
#### 3. 输入json，嵌套简单list
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
#### 4. 输入json，嵌套对象list
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
		images=(json['images'] as List)?.map((l)=>ImagesEntity.fromJson(l))?.toList();
	Map <String, dynamic> toJson() => {
		'id':id,
		'name':name,
		'images':images?.map((it)=>it.toJson())?.toList()
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
#### 5. 输入map列表。
这个需要强调一下，我的方法是，将[...]转化成{"datas": [...]}，之后再转换
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
		datas=(json['datas'] as List)?.map((l)=>DatasEntity.fromJson(l))?.toList();
	Map <String, dynamic> toJson() => {
		'datas':datas?.map((it)=>it.toJson())?.toList()
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
#### 6. 输入复杂json
在某新闻网页抓一个json，格式比较复杂
```json
{"message":"success","data":[{"title":"父亲车祸母亲失踪女孩急等骨髓救命48岁姑父为其寻母8年未间断","gallary_flag":2,"image_list":[{"url":"//p99.pstatp.com/list/364x360/pgc-image/9c14e3a8dd1141bf9e84482ec0a969fd"},{"url":"//p3.pstatp.com/list/272x178/pgc-image/fc93fe97e6254a00a8c54782c368a66a"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/51ea0b3d56484e64bb4173fb40d88941"}],"article_url":"/group/6631418812048605700/","cover_image_url":"//p99.pstatp.com/list/300x170/pgc-image/9c14e3a8dd1141bf9e84482ec0a969fd","gallery_image_count":14},{"title":"清朝12位皇帝真实容貌：道光帝开始脸变小，末代皇帝溥仪如此英俊","gallary_flag":1,"image_list":[{"url":"//p1.pstatp.com/list/640x360/pgc-image/1537076286050672437e773"},{"url":"//p3.pstatp.com/list/pgc-image/1537076286006e0a40f97e3"},{"url":"//p9.pstatp.com/list/pgc-image/1537076334677c121c62849"}],"article_url":"/group/6601692955138851342/","cover_image_url":"//p1.pstatp.com/list/300x170/pgc-image/1537076286050672437e773","gallery_image_count":12},{"title":"全世界最不可思议的十大土豪生活，只有你想不到的，没有做不到的","gallary_flag":1,"image_list":[{"url":"//p3.pstatp.com/list/640x360/pgc-image/15379270782881eb823c455"},{"url":"//p3.pstatp.com/list/pgc-image/1537927078358b5fb372180"},{"url":"//p3.pstatp.com/list/pgc-image/1537927078196fb83166b4a"}],"article_url":"/group/6605348757426930189/","cover_image_url":"//p3.pstatp.com/list/300x170/pgc-image/15379270782881eb823c455","gallery_image_count":10},{"title":"这3个景点都取消了门票费，免费让游客参观，你会考虑去一次吗？","gallary_flag":2,"image_list":[{"url":"//p9.pstatp.com/list/364x360/pgc-image/c3f7ca96ebe24b5380c9ead22f7dcc2b"},{"url":"//p9.pstatp.com/list/272x178/pgc-image/23aa8619a4284c1b88e92c5fe2a9d85e"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/ce7bcc2f39fc477db02e3f122272659e"}],"article_url":"/group/6624419395680600583/","cover_image_url":"//p9.pstatp.com/list/300x170/pgc-image/c3f7ca96ebe24b5380c9ead22f7dcc2b","gallery_image_count":8},{"title":"这三位明星背景强大，几乎没人敢惹","gallary_flag":2,"image_list":[{"url":"//p99.pstatp.com/list/dfic-imagehandler/0a786347-bc90-4db1-b14e-4e569344e402"},{"url":"//p1.pstatp.com/list/dfic-imagehandler/9fb8f421-0c9c-455c-a7fc-2a9e9d90cf80"},{"url":"//p3.pstatp.com/list/dfic-imagehandler/ef3b09a3-b4bb-4463-bb54-d72163d98559"}],"article_url":"/group/6630935274056581636/","cover_image_url":"//p99.pstatp.com/list/dfic-imagehandler/0a786347-bc90-4db1-b14e-4e569344e402","gallery_image_count":3},{"title":"古城修缮：复建中的明太原县城，晋阳古城遗址上的古城文脉传承","gallary_flag":1,"image_list":[{"url":"//p9.pstatp.com/list/640x360/b71f00046c2f82588541"},{"url":"//p3.pstatp.com/list/b71f00046c302e6b6f9d"},{"url":"//p1.pstatp.com/list/b72400031bb4f9fee5bd"}],"article_url":"/group/6601406546641420803/","cover_image_url":"//p9.pstatp.com/list/300x170/b71f00046c2f82588541","gallery_image_count":6},{"title":"像瓜不是瓜，像藕不是藕，农村夫妻祖传手艺制作稀罕物，日赚1000","gallary_flag":1,"image_list":[{"url":"//p99.pstatp.com/list/640x360/pgc-image/15368358594420267044bea"},{"url":"//p3.pstatp.com/list/pgc-image/153683585801878fe338032"},{"url":"//p3.pstatp.com/list/pgc-image/15368358580542cd67b1121"}],"article_url":"/group/6600699719456915976/","cover_image_url":"//p99.pstatp.com/list/300x170/pgc-image/15368358594420267044bea","gallery_image_count":9},{"title":"活佛眼睛（二）","gallary_flag":2,"image_list":[{"url":"//p3.pstatp.com/list/364x360/pgc-image/75e16a0f519b45f0a527b3f9228150ef"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/3154065bef234dfbbc0cd90ac8b765f8"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/7fe76b56fa844f46b4088ba62bf5e118"}],"article_url":"/group/6631057751093035534/","cover_image_url":"//p3.pstatp.com/list/300x170/pgc-image/75e16a0f519b45f0a527b3f9228150ef","gallery_image_count":3}]}
```
输出：
```dart
class Json6 {
	String message;
	List<DataEntity> data;
	Json6({
		this.message,
		this.data
	});

	Json6.fromJson(Map < String, dynamic > json):
		message=json['message'],
		data=(json['data'] as List)?.map((l)=>DataEntity.fromJson(l))?.toList();
	Map <String, dynamic> toJson() => {
		'message':message,
		'data':data?.map((it)=>it.toJson())?.toList()
	};
}

class DataEntity {
	String title;
	num gallary_flag;
	List<Image_listEntity> image_list;
	String article_url;
	String cover_image_url;
	num gallery_image_count;
	DataEntity({
		this.title,
		this.gallary_flag,
		this.image_list,
		this.article_url,
		this.cover_image_url,
		this.gallery_image_count
	});

	DataEntity.fromJson(Map < String, dynamic > json):
		title=json['title'],
		gallary_flag=json['gallary_flag'],
		article_url=json['article_url'],
		cover_image_url=json['cover_image_url'],
		gallery_image_count=json['gallery_image_count'],
		image_list=(json['image_list'] as List)?.map((l)=>Image_listEntity.fromJson(l))?.toList();
	Map <String, dynamic> toJson() => {
		'title':title,
		'gallary_flag':gallary_flag,
		'article_url':article_url,
		'cover_image_url':cover_image_url,
		'gallery_image_count':gallery_image_count,
		'image_list':image_list?.map((it)=>it.toJson())?.toList()
	};
}

class Image_listEntity {
	String url;
	Image_listEntity({
		this.url
	});

	Image_listEntity.fromJson(Map < String, dynamic > json):
		url=json['url'];
	Map <String, dynamic> toJson() => {
		'url':url
	};
}
```

## 测试
`./test_all.sh`
`pub run test`