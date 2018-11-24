import 'dart:io';

import 'entity_writer_builder.dart';
import 'path_parser.dart';
import 'utils.dart';


const String err = '''

ERROR PARAMETERS!!!

  Sample:
    dart cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/Age -v --json-serializable-support

  SYNOPSIS
    dart cli.dart -j <json_string> -o <output_path> [-v]
    -o, --output
          output path
    -j, --json: 
          input json string
    -v, --verbose: 
          print verbose info
    --json-serializable-support
          support json_serializable or not. default disable

''';

void main(List<String> arguments) {
  var outName;
  var pwd = getDir(Platform.script.path);
  var outPath = pwd + 'output/';  // default path
  var jstr;
  var json_serializable_support = false;
  for (var i = 0; i < arguments.length; i++) {
    var option = arguments[i];

    if (['-j', '--json'].contains(option)) {
      if (i < arguments.length - 1) {
        jstr = arguments[i + 1];
      }
    } else if (['-o', '--output'].contains(option)) {
      if (i < arguments.length - 1) {
        outPath = new Path(arguments[i + 1]).dir;
        outName = new Path(arguments[i + 1]).name;

        printWhen('output dir: $outPath', isVerbose(arguments));
        printWhen('output name: $outName', isVerbose(arguments));

        var exits = new Directory(outPath).existsSync();
        if (!exits) {
          printWhen('The path $outPath does not exists. AUTO CREATED', isVerbose(arguments));
          new Directory(outPath).createSync(recursive: true); 
        }
      }
    } else if ('--support-json-serializable' == option) {
      json_serializable_support = true;
    }
  }

  if (outName == null || jstr == null) {
    error();
  } else {
    // var pw = EntityWriter();
    // pw.setName(outName);
    // pw.setJson(jsonDecode(jstr));
    // pw.addHeaders(ConstStr.INSERT_HEADER);
    // pw.setDecorators(ConstStr.INSERT_DECORATOR);
    // pw.setInserts(ConstStr.INSERT_IN_CLASS);
    // pw.setOutputDir(outPath);
    // pw.convert();

    new EntityWriterBuilder()
    .supportJsonSerializable(json_serializable_support)
    .name(outName)
    .jsonStr(jstr)
    .outpath(outPath)
    .build()
    .convert();
  }
}

error([String s]) {
  stderr.write(s);
  stderr.write('\n\n');
  stderr.write(err);
  exit(-1);
}

bool isVerbose(arguments) {
  return arguments.contains('-v') || arguments.contains('--verbose');
}
