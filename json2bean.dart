import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'constant.dart';
import 'entity_writer.dart';
import 'utils.dart';




Future<void> main() async {

  var pwd = getDir(Platform.script.path);
  var input = '${pwd}input/input.json';

  var file = new File(input);
  var jstr = file.readAsStringSync();
  Map<String, dynamic> jobj = jsonDecode(jstr);

  jobj.forEach((k,v){
    var pw = EntityWriter();
    pw.setName(k);
    pw.setJson(jsonDecode(v));
    pw.addHeaders(ConstStr.INSERT_HEADER);
    pw.setDecorators(ConstStr.INSERT_DECORATOR);
    pw.setInserts(ConstStr.INSERT_IN_CLASS);
    pw.setOutputDir('${pwd}../lib/output/');
    pw.convert();
  });
}
