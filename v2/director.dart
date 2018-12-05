import 'dart:io';

import '../utils.dart';
import 'clazz.dart';
import 'json_serializable_clazz.dart';


class Director {

  bool support_json_serializable = false;
  // bool filename_camel_to_underline = true;
  bool show_verbose = false;
  String name;
  String path;
  String json;
  Clazz clazz;
  String output;

  Director(
    this.name,
    this.json,
    this.path,
    this.support_json_serializable, 
    this.show_verbose
    ) {
      if (support_json_serializable) {
        clazz = JsonSerializableClazz.fromJson(json);
        var part = buildPartName();
        clazz.addHeader('import \'package:json_annotation/json_annotation.dart\';');
        clazz.addHeader('part \'$part\';\n');
      } else {
        clazz = Clazz.fromJson(json);
      }
      output = clazz.toString();
  }

  action() {

    // 确保路径存在
    var directory = new Directory(path);
    directory.createSync(recursive: true);

    var fullPath = new File(buildOutputFullPath());
    var sink = fullPath.openWrite();
    sink.write(output);
    sink.close();
  }

  String buildOutputFullPath() => path + camel2dash(name) + '.dart';
  String buildPartName() => camel2dash(name) + '.g.dart';
}