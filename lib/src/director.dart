import 'dart:io';

import 'package:path/path.dart' as p;

import 'clazz.dart';
import 'config.dart';
import 'json_serializable_clazz.dart';
import 'utils.dart';

class Director {
  Clazz _clazz;
  Config config;

  Director(this.config) {
    if (config.json_serializable) {
      _clazz = JsonSerializableClazz.fromJson(config.input, key: config.name);
      var part = buildPartName();
      _clazz.addHeader(
          'import \'package:json_annotation/json_annotation.dart\';');
      _clazz.addHeader('part \'$part\';\n');
    } else {
      _clazz = Clazz.fromJson(config.input, key: config.name);
    }
  }

  /// Execute convert.
  action() {
    var output = _clazz.toString();
    if (config.output != null) {
      var fullPath = new File(buildOutputFullPath());
      // 确保路径存在
      fullPath.parent.createSync(recursive: true);
      if (fullPath.existsSync()) {
        stdout.writeln('File: $fullPath is aready exists, overwrite? Y/n');
        var prompt = stdin.readLineSync();
        if (!['y', 'yes'].contains(prompt.toLowerCase())) {
          stdout.writeln('Skipped generate file $fullPath');
          return;
        }
        stdout.writeln('file $fullPath will be overwrite');
      }
      var sink = fullPath.openWrite();
      sink.write(output);
      sink.close();
      printWhen('convert successful!', config.verbose);
    } else {
      stdout.add(output.codeUnits);
    }
  }

  String buildOutputFullPath() =>
      p.join(config.path, camel2dash(config.name) + '.dart');

  String buildPartName() => camel2dash(config.name) + '.g.dart';
}
