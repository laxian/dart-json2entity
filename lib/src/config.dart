import 'package:args/args.dart';
import 'package:path/path.dart';

class Config {
  String input;
  String file;
  String output;
  bool verbose;
  bool json_serializable;

  String get name => output != null ? basename(output) : 'Model';
  String get path => output != null ? dirname(output) : '.';
  bool get noInput => input == null && file == null;

  Config(
      {this.input,
      this.file,
      this.output,
      this.verbose = false,
      this.json_serializable = false});

  factory Config.from(ArgResults result) {
    var jsonStr = result['json'];
    var output = result['output'];
    var jsonsFile = result['file'];
    var verbose = result['verbose'];
    var supportJsonSerializable = result['json-serializable-support'];

    return Config(
        input: jsonStr,
        file: jsonsFile,
        output: output,
        verbose: verbose,
        json_serializable: supportJsonSerializable);
  }

  factory Config.copy(Config other) {
    return Config(
        input: other.input,
        file: other.file,
        output: other.output,
        verbose: other.verbose,
        json_serializable: other.json_serializable);
  }
}
