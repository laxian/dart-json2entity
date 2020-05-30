import 'dart:convert';

import 'package:json2entity/json2entity.dart';

void main(List<String> args) {
  if ((args?.isEmpty ?? true) || !(args[0] is String)) {
    print('请输入json字符串');
    return;
  }
  var json = args[0];
  var zippedJson = jsonEncode(zip(jsonDecode(json)));
  print(zippedJson);
}
