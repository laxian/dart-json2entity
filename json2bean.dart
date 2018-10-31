import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'constant.dart';
import 'entity_writer.dart';
import 'utils.dart';




Future<void> main() async {

  var input = getDir(Platform.script.path) + 'input/input.json';
  var file = new File(input);
  var jstr = file.readAsStringSync();
  Map<String, dynamic> jobj = jsonDecode(jstr);
  jobj.forEach((k,v){
    var pw = EntityWriter();
    pw.setName(k);
    pw.setJson(jsonDecode(v));
    pw.addHeaderStrs(ConstStr.json_serializable_insert_file_header_strs);
    pw.setBeforeClassStr(ConstStr.json_serializable_insert_before_class);
    pw.setInsertStr(ConstStr.json_serializable_insert_into_class);
    pw.setOutputDir(getDir(Platform.script.path) + 'output/');
    pw.convert();
  });
}
