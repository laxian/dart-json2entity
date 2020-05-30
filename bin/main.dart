import 'dart:convert';
import 'dart:io';

import 'package:json2entity/src/zip_map.dart';

var json = '''[{"a":null,"b":1,"c":"OK","d":{"e":0},"g":[{"h":1},{"j":3}]},
               {"a":true,"b":1,"d":{"f":1},"g":[{"i":2},{"k":4}]}]''';
var json_list =
    '''{"root":[{"a":null,"b":1,"c":"OK","d":{"e":0},"g":[{"h":1},{"j":3}]},
                            {"a":true,"b":1,"d":{"f":1},"g":[{"i":2},{"k":4}]}]}''';
void main() {
  // Map out = zip(a, b);

  // var out = zipN(jsonDecode(json));
  stdout.write('Y/n');
  String input = stdin.readLineSync();
  // stdout.flush();
  for (var i = 0; i < 100; i++) {
    var runSync = Process.runSync('echo', ['-en', '$i']);
    stdout.write('${runSync.stdout} \r');
  }
  // print(input);

  var out = zip(jsonDecode(json));
  print(out);
  var out2 = zip(jsonDecode(json_list));
  print(out2);
}
