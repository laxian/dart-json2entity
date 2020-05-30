import 'dart:convert';

import '../json2entity.dart';
import 'utils.dart';

/// A helper class that parse json strings to classes.
/// Clazz represents an entity class
class Clazz {
  /// Corresponding to child. Parent is a class that refers to the current entity class as field
  Clazz parent;

  /// a child is a class being used as field by current entity class
  List<Clazz> children = [];

  /// Header is a message inserted into the header of a file
  List<String> headers;

  /// Decorator is a tag before class
  List<String> decorators;

  String _name;

  final String _INDENT = '  ';
  final String _INDENT2 = '    ';

  /// Fields of current entity class
  Map<String, String> fields = {};

  /// Add a header
  void addHeader(String header) {
    headers ??= [];
    headers.add(header);
  }

  /// Add a decorator
  void addDecorator(String decor) {
    if (decorators == null) {
      decorators = [];
      decorators.add(decor);
    }
  }

  Clazz(this._name, this.fields, this.decorators, [this.parent]);

  /// Read from class source file. Not implements.
  Clazz.fromClass(String path, String name);

  /// Construct from json strings.
  factory Clazz.fromJson(String jsonStr, {String key}) {
    var jobj;
    try {
      jobj = jsonDecode(jsonStr);
    } on Exception catch (e) {
      throw FormatException(
          'Input Json Format Error! ${(e as FormatException).message}');
    }
    if (jobj is Map) {
      return Clazz.fromMap(jobj, key: key);
    }
    return Clazz.fromList(jobj, key: key);
  }

  /// Construct from Map.
  factory Clazz.fromMap(Map<String, dynamic> jsonMap,
      {String key, bool noZip = false}) {
    assert(jsonMap != null);
    var entry = MapEntry<String, Map<String, dynamic>>(
        key ?? 'AutoModel', noZip ? jsonMap : zip(jsonMap));
    return Clazz.fromMapEntry(entry);
  }

  /// Construct from list.
  /// [wrapKey] if not null, use [wrapKey] as KEY, [jsonList] as value
  /// convert the json list to an json object
  factory Clazz.fromList(List<dynamic> jsonList, {String key, String wrapKey}) {
    assert(jsonList != null);
    assert(jsonList.isNotEmpty);

    var map;
    var list = zipList(jsonList);
    if (wrapKey != null) {
      var wrapMap = <String, dynamic>{};
      wrapMap[wrapKey] = list;
      map = wrapMap;
    } else {
      map = list[0];
    }

    return Clazz.fromMap(map, key: key);
  }

  /// Construct from [MapEntry]
  Clazz.fromMapEntry(MapEntry<String, Map<String, dynamic>> entry)
      : _name = entry.key {
    var pending = entry.value;
    if (pending.entries.isEmpty) {
      return;
    }

    while (pending.entries.isNotEmpty) {
      var currName = pending.entries.elementAt(0).key;
      var currKey = buildClassName(currName);
      var curr = pending.remove(currName);

      if (curr is Map) {
        var child = buildChildClazz(curr, key: currKey);
        children.add(child);
        fields[currName] = currKey;
      } else if (curr is List) {
        // 对于json里的list，我们认为每一项都一样的类型
        var currList = curr;
        if (currList.isNotEmpty) {
          var curr = currList.elementAt(0);
          if (curr is Map) {
            var child = buildChildClazz(curr, key: currKey);
            children.add(child);
            fields[currName] = 'List<$currKey>';
          } else if (curr is List) {
            // [[],[]]
          } else {
            var type = getType(curr);
            fields[currName] = 'List<$type>';
          }
        } else {
          // key:[]
        }
      } else if (curr == null) {
        // key:null, as String
        fields[currName] = 'dynamic';
      } else {
        // int/float/bool/String
        fields[currName] = getType(curr);
      }
    }
  }

  /// Map json key to entity class name.
  String buildClassName(String currName) => '${capitalize(currName)}Entity';

  /// Build child Recursively.
  Clazz buildChildClazz(Map<String, dynamic> curr, {String key}) =>
      Clazz.fromMap(curr, key: capitalize(key));

  String get name => _name;

  String get parentName => parent?.name;

  /// Build class declare line.
  String buildClassDeclare() {
    if (hasValue(parentName)) {
      return 'class $_name extends $parentName {';
    }
    // default declare
    return 'class $_name {';
  }

  /// Build field declaration
  String buildFieldDeclare({String type, String name}) {
    return '${_INDENT}${type} ${buildFieldInConstructor(name: name)}';
  }

  /// Build field declaration
  String buildFieldInConstructor({String name}) {
    return name;
  }

  /// Build constructor of entity class
  String buildConstructor() {
    if (hasValue(fields)) {
      var pre = '${_INDENT}$_name({';
      var pairs = fields.entries.toList().map((kv) {
        return '${_INDENT2}this.${buildFieldInConstructor(name: kv.key)}';
      }).join(',\n');
      var suffix = '${_INDENT}})';
      var superConstructor = buildSuperConstructor();
      if (parent != null) {
        return '$pre\n$pairs\n$suffix:$superConstructor;\n';
      }
      return '$pre\n$pairs\n$suffix;\n';
    }
    return null;
  }

  /// Build fromJson method
  String buildFromJson() {
    var pre = '${_INDENT}$_name.fromJson(Map < String, dynamic > json)';
    var pairs = '';
    if (hasValue(fields)) {
      // 基础类型
      var simpleField = fields.entries
          .where((f) => _isSimple(f.value))
          .map((kv) => '${_INDENT2}${kv.key}=json[\'${kv.key}\']');

      // 对象类型需要调用自己类的fromJson，完成自身的序列化
      var objectField =
          fields.entries.where((f) => _isObject(f.value)).map((kv) {
        return '${_INDENT2}${kv.key}=${kv.value}.fromJson(json[\'${kv.key}\'])';
      });

      // 简单列表类型需要调用自己类的fromJson，完成自身的序列化
      var simpleListField =
          fields.entries.where((f) => _isSimpleList(f.value)).map((kv) {
        return '${_INDENT2}${kv.key}=${kv.value}.from(json[\'${kv.key}\'])';
      });

      // 对象列表类型需要调用自己类的fromJson，完成自身的序列化
      var objectListField =
          fields.entries.where((f) => _isObjectList(f.value)).map((kv) {
        return "${_INDENT2}${kv.key}=(json['${kv.key}'] as List)?.map((l)=>${_getItemType(kv.value)}.fromJson(l))?.toList()";
      });

      pairs = simpleField
          .followedBy(objectField)
          .followedBy(simpleListField)
          .followedBy(objectListField)
          .join(',\n');
      return '$pre:\n$pairs;';
    }
    return '$pre;';
  }

  /// Build super Constructor if have base class.
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

  /// Build toJson method of entity class
  String buildToJson() {
    var pre = '${_INDENT}Map <String, dynamic> toJson() => {';
    var post = '${_INDENT}};';
    if (hasValue(fields)) {
      var simpleField = fields.entries
          .where((f) => _isSimple(f.value))
          .map((kv) => '${_INDENT2}\'${kv.key}\':${kv.key}');

      var objectField = fields.entries
          .where((f) => _isObject(f.value))
          .map((kv) => '${_INDENT2}\'${kv.key}\':${kv.key}?.toJson()');

      var simpleListField = fields.entries
          .where((f) => _isSimpleList(f.value))
          .map((kv) => '${_INDENT2}\'${kv.key}\':${kv.key}');

      var objectListField = fields.entries
          .where((f) => _isObjectList(f.value))
          .map((kv) =>
              "${_INDENT2}\'${kv.key}':${kv.key}?.map((it)=>it.toJson())?.toList()");

      var pairs = simpleField
          .followedBy(objectField)
          .followedBy(simpleListField)
          .followedBy(objectListField)
          .join(',\n');
      return '$pre\n$pairs\n$post';
    }
    return '$pre$post';
  }

  /// Output entity class source as string.
  @override
  String toString() {
    // ��组成元素
    var classFrags = <String>[];
    // 0. headers
    String headerStr;
    if (hasValue(headers)) {
      headerStr = headers.join('\n');
      classFrags.add(headerStr);
    }
    var decor = '';
    // 1. decorators
    if (hasValue(decorators)) {
      decor = decorators.join('\n');
      classFrags.add(decor);
    }
    // 2. class declare
    var classDeclare = buildClassDeclare();
    classFrags.add(classDeclare);
    // 3. fields declare
    if (hasValue(fields)) {
      var fieldPairs = fields.entries.toList().map((kv) {
        //'${_INDENT}${kv.value} ${kv.key}';
        return buildFieldDeclare(type: kv.value, name: kv.key);
      }).join(';\n');
      classFrags.add('$fieldPairs;');
    }
    // 4. constructor
    var constructor = buildConstructor();
    classFrags.add(constructor);
    // 5. fromJson
    var fromJson = buildFromJson();
    classFrags.add(fromJson);
    // 6. toJson
    var toJson = buildToJson();
    classFrags.add(toJson);
    classFrags.add('}');

    // 7. build class
    var self = classFrags.where((str) => hasValue(str)).join('\n');
    var classes = [];
    classes.add(self);

    // 8. build child classes
    for (var child in children) {
      classes.add(child.toString());
    }

    // 9. success
    return classes.join('\n\n');
  }
}

// Is the type of [key] primary type
bool _isSimple(String key) {
  return ['bool', 'String', 'num'].contains(key);
}

// Is the type of [key] list
bool _isList(String key) {
  return key.startsWith('List<');
}

String _getItemType(String key) {
  if (!_isList(key)) {
    return key;
  }
  key = key.replaceAll('List<', '');
  var lastIndex = key.lastIndexOf('>');
  var type = key.substring(0, lastIndex);
  return type;
}

bool _isSimpleList(String key) {
  if (!_isList(key)) {
    return false;
  }
  var second = key.endsWith('>');
  key = key.replaceAll('List<', '');
  var lastIndex = key.lastIndexOf('>');
  var type = key.substring(0, lastIndex);
  var third = ['bool', 'String', 'num'].contains(type);
  return second && third;
}

bool _isObjectList(String key) {
  return _isList(key) && !_isSimpleList(key);
}

bool _isObject(String key) {
  return !_isSimple(key) && !_isList(key);
}
