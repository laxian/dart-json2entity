import 'clazz.dart';
import '../utils.dart';
import 'json_serializable_clazz.dart';

// 5种不同类型json测试用例，分别是
// 简单无嵌套json
// 嵌套json
// 嵌套简单列表json
// 嵌套对象列表json
// 对象列表json
var json1 = '{"result":1,"msg":"ok"}';
var json2 = '{"result":1,"msg":"ok","data":{"answer":"A"}}';
var json3 = '{"city":"Mumbai","streets":["address1","address2"]}';
var json4 = '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
var json5 = '[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]';

main(List < String > args) {
  // testHasValue();
  // testConvert();
  testConvertJsonSerializableSupport();
}

void testConvertJsonSerializableSupport() {
  var clazz1 = JsonSerializableClazz.fromJson(json1);
  print(clazz1.toString());
  var clazz2 = JsonSerializableClazz.fromJson(json2);
  print(clazz2.toString());
  var clazz3 = JsonSerializableClazz.fromJson(json3);
  print(clazz3.toString());
  var clazz4 = JsonSerializableClazz.fromJson(json4);
  print(clazz4.toString());
  var clazz5 = JsonSerializableClazz.fromJson(json5);
  print(clazz5.toString());
}

void testConvert() {
  var clazz1 = Clazz.fromJson(json1);
  print(clazz1.toString());
  var clazz2 = Clazz.fromJson(json2);
  print(clazz2.toString());
  var clazz3 = Clazz.fromJson(json3);
  print(clazz3.toString());
  var clazz4 = Clazz.fromJson(json4);
  print(clazz4.toString());
  var clazz5 = Clazz.fromJson(json5);
  print(clazz5.toString());
}

void testHasValue() {
  print(hasValue(null));
  print(hasValue(''));
  print(hasValue('abc'));
  print(hasValue([]));
  print(hasValue([1]));
  print(hasValue({}));
  print(hasValue({
    "result": 1
  }));
}