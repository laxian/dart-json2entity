import 'dart:convert';
import 'dart:io';

import 'constant.dart';
import 'entity_writer.dart';
import 'path_parser.dart';
import 'utils.dart';

/// dart cli.dart -j '''{"age":18,"name":"zhouweixian"}''' -o Age

const String err = '''
error parameters

  Sample:
    dart cli.dart -o Age -j \'{"age":18,"name":"zhouweixian"}\' -v
    
    -o or --output: output path
    -j or --json: json string
    -v or --verbose: print verbose info

''';

void main(List<String> arguments) {
  var outName;
  var pwd = getDir(Platform.script.path);
  var outPath = pwd + 'output/';
  var jstr;
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
          error('Then path $outPath does not exists');
        }
      }
    }
  }

  if (outName == null || jstr == null) {
    error();
  } else {
    var pw = EntityWriter();
    pw.setName(outName);
    pw.setJson(jsonDecode(jstr));
    pw.addHeaders(ConstStr.INSERT_HEADER);
    pw.setDecorators(ConstStr.INSERT_DECORATOR);
    pw.setInserts(ConstStr.INSERT_IN_CLASS);
    pw.setOutputDir(outPath);
    pw.convert();
  }
}

error([String s]) {
  stderr.write(s);
  stderr.write('\n\n');
  stderr.write(err);
  exit(-1);
}

printWhen(info, b) {
  if (b) {
    print(info);
  }
}

bool isVerbose(arguments) {
  return arguments.contains('-v') || arguments.contains('--verbose');
}
