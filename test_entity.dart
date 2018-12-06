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