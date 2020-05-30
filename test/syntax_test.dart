import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:json2entity/json2entity.dart';
import 'package:test/test.dart';

import '../example/example.dart';

/// 对生成的实体类源文件进行语法检查
/// 利用ast抽象语法树，解析，错误的语法无法通过测试
void main() {
  testConvert();
  testConvertJsonSerializableSupport();
}

void testConvertJsonSerializableSupport() {
  var clazz1 = JsonSerializableClazz.fromJson(json1);
  astNotNull(clazz1);
  var clazz2 = JsonSerializableClazz.fromJson(json2);
  astNotNull(clazz2);
  var clazz3 = JsonSerializableClazz.fromJson(json3);
  astNotNull(clazz3);
  var clazz4 = JsonSerializableClazz.fromJson(json4);
  astNotNull(clazz4);
  var clazz5 = JsonSerializableClazz.fromJson(json5);
  astNotNull(clazz5);
  var clazz6 = JsonSerializableClazz.fromJson(json6);
  astNotNull(clazz6);
  var clazz61 = JsonSerializableClazz.fromJson(json6, camelize: true);
  astNotNull(clazz61);
}

/// 对生成的实体类进行语法检查，确保ast抽象语法树解析成功
void astNotNull(Clazz clazz1) {
  var ast;
  try {
    ast = parseString(content: clazz1.toString()).unit;
  } on Exception catch (e) {
    print(e);
  }
  test('jsc test', () {
    expect(ast, isNot(equals(null)));
  });
}

void testConvert() {
  var clazz1 = Clazz.fromJson(json1);
  astNotNull(clazz1);
  var clazz2 = Clazz.fromJson(json2);
  astNotNull(clazz2);
  var clazz3 = Clazz.fromJson(json3);
  astNotNull(clazz3);
  var clazz4 = Clazz.fromJson(json4);
  astNotNull(clazz4);
  var clazz5 = Clazz.fromJson(json5);
  astNotNull(clazz5);
  var clazz6 = JsonSerializableClazz.fromJson(json6);
  astNotNull(clazz6);
}
