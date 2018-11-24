import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'constant.dart';
import 'entity_writer.dart';
import 'entity_writer_builder.dart';
import 'utils.dart';


Future < void > main() async {

  var pwd = getDir(Platform.script.path);
  var input = '${pwd}input/input.json';

  var file = new File(input);
  var jstr = file.readAsStringSync();
  Map < String, dynamic > jobj = jsonDecode(jstr);

  jobj.forEach((k, v) {
    EntityWriterBuilder()
    .supportJsonSerializable(false)
    .name(k)
    .jsonStr(v)
    .outpath('${pwd}/output/')
    .build()
    .convert();
  });
}