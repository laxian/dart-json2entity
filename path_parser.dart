
import 'dart:io';

import 'package:aixue4/code-generate/utils.dart';

class Path {

  String home;
  String pwd;
  String parent;
  String _path;

  Path(String path) {
    home = Platform.environment['HOME'];
    pwd = new File(Platform.script.path).parent.path;
    parent = new File(pwd).parent.path;

    if (path.startsWith('~')) {
      path = path.replaceFirst('~', home);
    } else if (path.startsWith('..')) {
      path = path.replaceFirst('..', pwd);
    } else if (path.startsWith('.')) {
      path = path.replaceFirst('.', parent);
    }
    _path = path;
  }

  get dir => getDir(_path);
  get name => _path.replaceFirst(dir, '');
}


/// test Path
main() {

  var a = './abc';
  var b = '../abc';
  var c = '~/abc';
  var d = '/abc';
  var e = '/abc/';
  print(new Path(a).dir);
  print(new Path(a).name);
  print(new Path(b).dir);
  print(new Path(b).name);
  print(new Path(c).dir);
  print(new Path(c).name);
  print(new Path(d).dir);
  print(new Path(d).name);
  print(new Path(e).dir);
  print(new Path(e).name);
}
