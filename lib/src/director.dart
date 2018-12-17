import 'dart:io';
import 'package:path/path.dart' as p;
import 'utils.dart';
import 'clazz.dart';
import 'json_serializable_clazz.dart';

class Director {
  /// Flag indicates whether supprt json_serializable.
  bool support_json_serializable = false;

  /// Print verbose infomation if true.
  bool show_verbose = false;

  /// Entity file name.
  String name;

  /// Entity file path.
  String outputPath;

  /// Input JSON string.
  String json;
  Clazz _clazz;
  String _output;

  Director(this.name, this.json, this.outputPath,
      this.support_json_serializable, this.show_verbose) {
    if (support_json_serializable) {
      _clazz = JsonSerializableClazz.fromJson(json, key: name);
      var part = buildPartName();
      _clazz.addHeader(
          'import \'package:json_annotation/json_annotation.dart\';');
      _clazz.addHeader('part \'$part\';\n');
    } else {
      _clazz = Clazz.fromJson(json, key: name);
    }
    _output = _clazz.toString();
  }

  /// Execute convert.
  action() {
    if (outputPath != null) {
      // 确保路径存在
      var directory = new Directory(outputPath);
      directory.createSync(recursive: true);

      var fullPath = new File(buildOutputFullPath());
      var sink = fullPath.openWrite();
      sink.write(_output);
      sink.close();
      printWhen('convert successful!', show_verbose);
    } else {
      stdout.add(_output.codeUnits);
    }
  }

  String buildOutputFullPath() =>
      p.join(outputPath, camel2dash(name) + '.dart');
  String buildPartName() => camel2dash(name) + '.g.dart';
}
