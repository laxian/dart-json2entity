import 'dart:convert';
import 'dart:io';

import 'v1/ew_builder.dart';
import 'path_parser.dart';
import 'utils.dart';
import 'v2/director.dart';


const String err = '''

ERROR PARAMETERS!!!

  Sample:
    dart cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/Age -v --json-serializable-support

  SYNOPSIS
    dart cli.dart -j <json_string> -o <output_path> [-v] [-s]
    -o, --output
          output path
    -j, --json: 
          input json string
    -f, --file: 
          input json list from file. See \$PROJECT_ROOT/input/input.json
    -v, --verbose: 
          print verbose info
    -s, --json-serializable-support
          support json_serializable or not. default disable
    -V, --v1
          use v1 convertor.[DEPRECATED]

''';

void main(List<String> arguments) {
  checkArgs(arguments);
  var outName;
  var pwd = getDir(Platform.script.path);
  var outPath = pwd + 'output/';  // default path
  var jstr;
  var inputFile;
  var support_json_serializable = false;
  for (var i = 0; i < arguments.length; i++) {
    var option = arguments[i];

    if (['-j', '--json'].contains(option)) {
      if (i < arguments.length - 1) {
        jstr = arguments[i + 1];
      }
    } else if (['-f', '--file'].contains(option)) {
      if (i < arguments.length - 1) {
        inputFile = new Path(arguments[i + 1]).path;
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
    } else if (['-s', '--support-json-serializable'].contains(option)) {
      support_json_serializable = true;
    }
  }

  if (outName == null || (jstr == null && inputFile == null)) {
    error();
  } else {
    if (jstr != null) {
      printWhen('input from stdin mode', isVerbose(arguments));
      doConvert(support_json_serializable, outName, jstr, outPath, isVerbose(arguments), v1: useV1(arguments));
          } else if (inputFile != null) {
            printWhen('input from file mode', isVerbose(arguments));
            converFromFile(inputFile, outPath, show_verbose: isVerbose(arguments), support_json_serializable: support_json_serializable, v1: useV1(arguments));
          }
        }
      }
      
useV1(List<String> arguments) {
  return arguments.contains('-V') || arguments.contains('--v1');
}

error([String s]) {
  if (s != null) {
    stderr.write(s);
  }
  stderr.write('\n\n');
  stderr.write(err);
  exit(-1);
}

bool isVerbose(arguments) {
  return arguments.contains('-v') || arguments.contains('--verbose');
}

bool checkArgs(List args) {
  if (!(args.contains('-j') || args.contains('--json')||
    args.contains('-f') || args.contains('--file'))) {
    error('\nERROR: NO INPUT FOUND!!!');
  }
  if (!(args.contains('-o') || args.contains('--output'))) {
    error('\nERROR: -O or --output NOT FOUND!');
  }
}

void converFromFile(String input, String outPath, {bool show_verbose: false, bool support_json_serializable: false, bool v1: false}) {
  
  var file = new File(input);
  var jstr = file.readAsStringSync();
  Map <String, dynamic> jobj = jsonDecode(jstr);

  printWhen('input: $input', show_verbose);
  printWhen('output: $outPath', show_verbose);
  
  jobj.forEach((k, v) {
    doConvert(support_json_serializable, k, v, outPath, show_verbose, v1: v1);
  });
}

void doConvert(bool support_json_serializable, String name, json, String outPath, bool show_verbose, {v1: bool}) {
  if(v1) {
    EntityWriterBuilder()
    .supportJsonSerializable(support_json_serializable)
    .name(name)
    .jsonStr(json)
    .outpath(outPath)
    .verbose(show_verbose)
    .build()
    .convert();
  } else {
    var director = Director(name, json, outPath, support_json_serializable, show_verbose);
    director.action();
  }
}