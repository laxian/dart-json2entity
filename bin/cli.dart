import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:json2entity/json2entity.dart';
import 'package:path/path.dart' as p;

main(List<String> args) {
  run(args);
}

void run(List<String> args) {
  ArgParser parser = initArgParser();
  var result;
  try {
    result = parser.parse(args);
  } on Exception catch (e) {
    _handleArgError(parser, e.toString());
  }
  var jsonStr = result['json'];
  var output = result['output'];
  var jsonsFile = result['file'];
  var verbose = result['verbose'];
  var support_json_serializable = result['json-serializable-support'];
  var help = result['help'];

  if (help) {
    stdout.write('Usage:\n\t${parser.usage.replaceAll('\n', '\n\t')}');
    return;
  }
  if (jsonStr == null && jsonsFile == null) {
    _handleArgError(parser, 'No input args found\n');
  }
  if (output == null) {
    _handleArgError(parser, 'No output args found\n');
  }

  var name = p.basename(output);
  var outPath = p.dirname(output);
  if (jsonStr != null) {
    doConvert(name, jsonStr, outPath, verbose, support_json_serializable);
  } else {
    converFromFile(jsonsFile, output, show_verbose: verbose);
  }
}

void _handleArgError(ArgParser parser, [String msg]) {
  if (msg != null) {
    stderr.write(msg);
  }
  stdout.write('Usage:\n\t${parser.usage.replaceAll('\n', '\n\t')}');
  exit(1);
}

ArgParser initArgParser() {
  return ArgParser()
    ..addOption('json', abbr: 'j', help: 'Input json string')
    ..addOption('file', abbr: 'f', help: 'Input json from file')
    ..addOption('output', abbr: 'o', help: 'Input output file path and name')
    ..addFlag('verbose', abbr: 'v', help: 'Show verbose')
    ..addFlag('json-serializable-support',
        abbr: 's', help: 'Indicates whether json-serializable is supported')
    ..addFlag('help', abbr: 'h', help: 'Help');
}

void converFromFile(String input, String outPath,
    {bool show_verbose: false, bool support_json_serializable: false}) {
  var file = new File(input);
  var jstr = file.readAsStringSync();
  Map<String, dynamic> jobj = jsonDecode(jstr);

  printWhen('input: $input', show_verbose);
  printWhen('output: $outPath', show_verbose);

  jobj.forEach((k, v) {
    doConvert(k, v, outPath, show_verbose, support_json_serializable);
  });
}

void doConvert(String name, json, String outPath, bool show_verbose,
    bool support_json_serializable) {
  try {
    var director =
        Director(name, json, outPath, support_json_serializable, show_verbose);
    director.action();
  } on FormatException catch (e) {
    print(e.message);
  } catch (e) {
    print(e.toString());
  }
}
