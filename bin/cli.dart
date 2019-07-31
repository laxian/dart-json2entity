import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:json2entity/json2entity.dart';
import 'package:json2entity/src/config.dart';
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

  if (result['help']) {
    stdout.write('Usage:\n\t${parser.usage.replaceAll('\n', '\n\t')}');
    return;
  }

  var config = Config.from(result);
  if (config.noInput) {
    _handleArgError(parser, 'No input args found\n');
  }
  if (config.output == null) {
    doConvert(config);
  } else {
    if (config.input != null) {
      doConvert(config);
    } else {
      converFromFile(config);
    }
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

void converFromFile(Config config) {
  var file = new File(config.file);
  var jstr = file.readAsStringSync();
  Map<String, dynamic> jobj = jsonDecode(jstr);

  printWhen('input: ${config.file}', config.verbose);
  printWhen('output: ${config.output}', config.verbose);

  jobj.forEach((k, v) {
    var c = Config.copy(config);
    c.input = v;
    c.output = p.join(c.output, k);
    doConvert(c);
  });
}

void doConvert(Config config) {
  try {
    var director = Director(config);
    director.action();
  } on FormatException catch (e) {
    print(e.message);
  } catch (e) {
    print(e.toString());
  }
}
