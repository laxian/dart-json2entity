import 'dart:convert';

import '../utils.dart';
import 'utils.dart';

class Clazz {
  var defaultName = 'AutoModel';
  List childs = [];

  List<String> headers;
  List<String> decorators;

  String _name;

  Clazz parent;

  Map<String, String> fields = {};

  addHeader(String header) {
    if (headers == null) {
      headers = [];
    }
    headers.add(header);
  }

  addDecorator(String decor) {
    if (decorators == null) {
      decorators = [];
      decorators.add(decor);
    }
  }

  Clazz(this._name, this.fields, this.decorators, [this.parent]);

  Clazz.fromClass(String path, String name);

  factory Clazz.fromJson(String jsonStr, {String key}) =>
      Clazz.fromMap(jsonDecode(jsonStr), key: key);

  factory Clazz.fromMap(Map<String, dynamic> jsonMap, {String key}) {
    assert(jsonMap != null);
    var entry =
        new MapEntry<String, Map<String, dynamic>>(key ?? 'AutoModel', jsonMap);
    return Clazz.fromMapEntry(entry);
  }

  Clazz.fromMapEntry(MapEntry<String, Map<String, dynamic>> entry)
      : _name = entry.key {
    var pending = entry.value;
    if (pending.entries.length == 0) {
      return;
    }

    while (pending.entries.length > 0) {
      var currName = pending.entries.elementAt(0).key;
      var currKey = buildClassName(currName);
      var curr = pending.remove(currName);

      if (curr is Map) {
        var child = buildChildClazz(curr, key: currKey);
        childs.add(child);
        fields[currName] = currKey;
      } else if (curr is List) {
        // 对于json里的list，我们认为每一项都一样的类型
        var currList = curr as List;
        if (currList.length > 0) {
          var curr = currList.elementAt(0);
          if (curr is Map) {
            var child = buildChildClazz(Map(), key: currName);
            childs.add(child);
            fields[currName] = 'List<$currKey>';
          } else if (curr is List) {
            // [[],[]]
          } else {
            fields[currName] = getType(curr);
          }
        } else {
          // key:[]
        }
      } else if (curr == null) {
        // key:null, as String
        fields[currName] = 'String';
      } else {
        // int/float/bool/String
        fields[currName] = getType(curr);
      }
    }
  }

  String buildClassName(String currName) => '${capitalize(currName)}Entity';

  Clazz buildChildClazz(Map curr, {String key}) =>
      Clazz.fromMap(curr, key: capitalize(key));

  get name => _name;

  // type: value. eg. int age.
  String get parentName => parent?.name;

  String buildClassDeclare() {
    if (hasValue(parentName)) {
      return 'class $_name extends $parentName {';
    }
    // default declare
    return 'class $_name {';
  }

  String buildConstructor() {
    if (hasValue(fields)) {
      String pre = '$_name({';
      var pairs = fields.entries.toList().map((kv) {
        return 'this.${kv.key}';
      }).join(',');
      String suffix = '})';
      var superConstructor = buildSuperConstructor();
      if (parent != null) {
        return '$pre\n$pairs\n$suffix:$superConstructor;\n';
      }
      return '$pre\n$pairs\n$suffix;\n';
    }
    return null;
  }

  String buildFromJson() {
    var pre = '$_name.fromJson(Map < String, dynamic > json)';
    var pairs = '';
    if (hasValue(fields)) {
      pairs = fields.entries.toList().map((kv) {
        return '${kv.key}=json[\'${kv.key}\']';
      }).join(',');
      return '$pre:\n$pairs;';
    }
    return '$pre;';
  }

  String buildSuperConstructor() {
    var frags = [];
    var pre = 'super(';
    frags.add(pre);
    if (hasValue(fields)) {
      var pairs = fields.entries.map((kv) => kv.key).join(',');
      frags.join(pairs);
    }
    var post = ')';
    frags.add(post);
    return frags.join();
  }

  String buildToJson() {
    var pre = 'Map <String, dynamic> toJson() => {';
    var post = '};';
    var pairs = '';
    if (hasValue(fields)) {
      pairs = fields.entries.toList().map((kv) {
        return '\'${kv.key}\':${kv.key}';
      }).join(',');
      return '$pre\n$pairs\n$post';
    }
    return '$pre$post';
  }

  @override
  String toString() {
    // 类组成元素
    List<String> classFrags = <String>[];
    // 0. headers
    String headerStr;
    if (hasValue(headers)) {
      headerStr = headers.join('\n');
      classFrags.add(headerStr);
    }
    String decor = '';
    // 1. decorators
    if (hasValue(decorators)) {
      decor = decorators.join('\n');
      classFrags.add(decor);
    }
    // 2. class declare
    String classDeclare = buildClassDeclare();
    classFrags.add(classDeclare);
    // 3. fields declare
    if (hasValue(fields)) {
      var fieldPairs = fields.entries.toList().map((kv) {
        return '${kv.value} ${kv.key}';
      }).join(';\n');
      classFrags.add('$fieldPairs;');
    }
    // 4. constructor
    String constructor = buildConstructor();
    classFrags.add(constructor);
    // 5. fromJson
    String fromJson = buildFromJson();
    classFrags.add(fromJson);
    // 6. toJson
    String toJson = buildToJson();
    classFrags.add(toJson);
    classFrags.add('}');

    // 7. build class
    var self = classFrags.where((str) => hasValue(str)).join('\n');
    List<String> classes = [];
    classes.add(self);

    // 8. build child classes
    for (var child in childs) {
      classes.add(child.toString());
    }

    // 9. success
    return classes.join('\n\n');
  }
}
