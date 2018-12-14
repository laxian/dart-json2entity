import 'dart:convert';
import 'package:test/test.dart';

import '../sample/output/json1.dart';
import '../sample/output/json2.dart';
import '../sample/output/json3.dart';
import '../sample/output/json4.dart';
import '../sample/output/json5.dart';
import '../sample/output/json6.dart';
import '../sample/output/json_f1.dart';
import '../sample/output/json_f2.dart';
import '../sample/output/json_f3.dart';
import '../sample/output/json_f4.dart';
import '../sample/output/json_f5.dart';
import '../sample/output/json_f6.dart';
import '../sample/output/json_s1.dart';
import '../sample/output/json_s2.dart';
import '../sample/output/json_s3.dart';
import '../sample/output/json_s4.dart';
import '../sample/output/json_s5.dart';
import '../sample/output/json_s6.dart';
import '../sample/input.dart';

// NOTE: to test outputs above, U need generate outputs first by run test_all.sh
main() {
  print('测试命令行转换的普通实体类 ->');
  testEntityConvertedByCli();
  print('\n测试文件批量转换的普通实体类 ->');
  testEntityConvertedFromFile();
  print('\n测试支持json_serializable的实体类 ->');
  testEntityConvertedSupportJsonSerializable();
}

void testEntityConvertedByCli() {
  var j1 = Json1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);

  var j2 = Json2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');

  var j3 = Json3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');

  var j4 = Json4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);

  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas":[...]}
  var list = jsonDecode(json5);
  var j5 = Json5.fromJson({'datas': list});
  assertTrue(j5.datas.length == 1);

  var j6 = Json6.fromJson(jsonDecode(json6));
  assertTrue(j6.data.length == 8, tag: 'data.length is ${j6.data.length}');
  assertTrue(j6.data[0].image_list.length == 3);
}

void testEntityConvertedSupportJsonSerializable() {
  var j1 = JsonS1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);

  var j2 = JsonS2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');

  var j3 = JsonS3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');

  var j4 = JsonS4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);

  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas":[...]}
  var list = jsonDecode(json5);
  var j5 = JsonS5.fromJson({'datas': list});
  assertTrue(j5.datas.length == 1);

  var j6 = JsonS6.fromJson(jsonDecode(json6));
  assertTrue(j6.data.length == 8, tag: 'data.length is ${j6.data.length}');
  assertTrue(j6.data[0].image_list.length == 3);
}

void testEntityConvertedFromFile() {
  var j1 = JsonF1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);

  var j2 = JsonF2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');

  var j3 = JsonF3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');

  var j4 = JsonF4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);

  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas":[...]}
  var list = jsonDecode(json5);
  var j5 = JsonF5.fromJson({'datas': list});
  assertTrue(j5.datas.length == 1);

  var j6 = JsonF6.fromJson(jsonDecode(json6));
  assertTrue(j6.data.length == 8, tag: 'data.length is ${j6.data.length}');
  assertTrue(j6.data[0].image_list.length == 3);
}

void assertTrue(bool b, {String tag}) {
  test(tag ?? 'test', () {
    expect(b, equals(true));
  });
}
