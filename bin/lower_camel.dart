import 'dart:io';

import 'package:json2entity/json2entity.dart';

/// in project root dir, run:
/// pub run ./test_all.sh to generate example files
/// then run:
/// pub run lower_camel.dart example/output/json_s6.dart
/// or:  `pub global activate --source path .` then run `camelize "<xxx>.dart"`
/// or:  `pub global activate json2entity` then run `camelize "<xxx>.dart"`
main(List<String> args) {
  if (args.length == 0) {
    print("Usage: camelize <filename>");
    exit(1);
  }
  var filePath = args[0];
  camelize(filePath);
}

/// 输入dart文件路径，将其字段中带有下划线'_'的，转换成驼峰风格
/// 原文件，慎重使用
void camelize(String filePath) {
  var file = new File(filePath);
  if (!file.existsSync()) {
    print('${filePath} not exists! exit');
    exit(2);
  }
  var fileContent = file.readAsStringSync();
  var prefix = "@JsonKey(name: 'HOLDER')";

  RegExp exp =
      new RegExp(r"([ \f\t]*?)[a-zA-Z<>_]+\s+([a-zA-Z]+(?:_[a-zA-Z]+)+);");
  RegExp exp2 = new RegExp(r"\.([a-z]+(?:_[a-z]+)+)");
  Iterable<RegExpMatch> matches = exp.allMatches(fileContent);
  print(matches.length);
  matches.forEach((m) {
    var line = m.group(0);
    var space = m.group(1);
    var underscore = m.group(2);
    print("add JsonKey on " + underscore);
    var camel = underscore2Camel(underscore.toLowerCase());
    var pre = prefix.replaceAll('HOLDER', underscore);
    var camelLine = line.replaceAll(underscore, camel);
    var newLine = space + pre + '\n' + camelLine;
    fileContent = fileContent.replaceFirst(line, newLine);
  });
  matches.forEach((m) {
    var underscore = m.group(2);
    print("modify constructor " + underscore);
    fileContent = fileContent.replaceFirst(
        exp2, "." + underscore2Camel(underscore.toLowerCase()));
  });
  // print(fileContent);
  file.writeAsString(fileContent);
  print("the end");
}
