import 'dart:async' show Future;
import 'dart:io';

import '../cli.dart';
import '../utils.dart';

/// dart sample2.dart
Future < void > main() async {

  var pwd = getDir(Platform.script.path);
  var input = '${pwd}input/input.json';
  var outPath = '${pwd}/output/';

  converFromFile(input, outPath);
}