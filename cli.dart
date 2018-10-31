import 'dart:convert';
import 'dart:io';

import 'constant.dart';
import 'entity_writer.dart';
import 'utils.dart';


/// dart cli.dart -j '''{"age":18,"name":"zhouweixian"}''' -o Age


const String err = '''
error parameters

  Sample:
    dart cli.dart -o Age -j \'{"age":18,"name":"zhouweixian"}\'

''';

void main(List<String> arguments){

  var outName;
  var jstr;
  for(var i =0; i< arguments.length; i++) {
    var option = arguments[i];

    if(['-j', '--json'].contains(option)) {
      if(i < arguments.length - 1) {
        jstr = arguments[i+1];
      }
    } else if (['-o', '--output'].contains(option)) {
      if(i < arguments.length - 1) {
        outName = arguments[i+1];
      }
    }
  }

  if(outName == null || jstr == null) {
    print(err);
  } else {
    var pw = EntityWriter();
    pw.setName(outName);
    pw.setJson(jsonDecode(jstr));
    pw.addHeaderStrs(ConstStr.json_serializable_insert_file_header_strs);
    pw.setBeforeClassStr(ConstStr.json_serializable_insert_before_class);
    pw.setInsertStr(ConstStr.json_serializable_insert_into_class);
    pw.setOutputDir(getDir(Platform.script.path) + 'output/');
    pw.convert();
  }

}