import 'dart:convert';

import 'utils.dart';


/// A helper class that parse json strings to classes.
/// Clazz represents an entity class
class Clazz {

  /// Default name of current entity class
  var defaultName = 'AutoModel';

  /// a child is a class being used as field by current entity class
  List children = [];

  /// Header is a message inserted into the header of a file
  List<String> headers;

  /// Decorator is a tag before class
  List<String> decorators;

  String _name;

  /// Corresponding to child. Parent is a class that refers to the current entity class as field
  Clazz parent;

  /// Fields of current entity class
  Map<String, String> fields = {};

  /// Add a header
  addHeader(String header) {
    if (headers == null) {
      headers = [];
    }
    headers.add(header);
  }

  /// Add a decorator
  addDecorator(String decor) {
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
      throw FormatException('Input Json Format Error! ${(e as FormatException).message}');
    }
    if (jobj is Map) {
      return Clazz.fromMap(jobj, key: key);
    }
    return Clazz.fromList(jobj, key: key);
  }

  /// Construct from Map.
  factory Clazz.fromMap(Map<String, dynamic> jsonMap, {String key}) {
    assert(jsonMap != null);
    var entry =
        new MapEntry<String, Map<String, dynamic>>(key ?? 'AutoModel', jsonMap);
    return Clazz.fromMapEntry(entry);
  }

  /// Construct from list.
  /// Firstly, convert to Map. Then invoke [fromMap] method
  factory Clazz.fromList(List<dynamic> jsonList, {String key}) {
    assert(jsonList != null);
    assert(jsonList.length > 0);

    String default_key = 'datas';
    var newMap = <String, dynamic>{};
    newMap[default_key] = jsonList;

    return Clazz.fromMap(newMap, key: key);
  }

  /// Construct from [MapEntry]
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
        children.add(child);
        fields[currName] = currKey;
      } else if (curr is List) {
        // 对于json里的list，我们认为每一项都一样的类型
        var currList = curr;
        if (currList.length > 0) {
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
        fields[currName] = 'String';
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

  get name => _name;

  String get parentName => parent?.name;

  /// Build class declare line.
  String buildClassDeclare() {
    if (hasValue(parentName)) {
      return 'class $_name extends $parentName {';
    }
    // default declare
    return 'class $_name {';
  }

  /// Build constructor of entity class
  String buildConstructor() {
    if (hasValue(fields)) {
      String pre = '\t$_name({';
      var pairs = fields.entries.toList().map((kv) {
        return '\t\tthis.${kv.key}';
      }).join(',\n');
      String suffix = '\t})';
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
    var pre = '\t$_name.fromJson(Map < String, dynamic > json)';
    var pairs = '';
    if (hasValue(fields)) {
      // 基础类型
      Iterable<String> simpleField = fields.entries
          .where((f) => _isSimple(f.value))
          .map((kv) => '\t\t${kv.key}=json[\'${kv.key}\']');

      // 对象类型需要调用自己类的fromJson，完成自身的序列化
      Iterable<String> objectField =
          fields.entries.where((f) => _isObject(f.value)).map((kv) {
        return '\t\t${kv.key}=${kv.value}.fromJson(json[\'${kv.key}\'])';
      });

      // 简单列表类型需要调用自己类的fromJson，完成自身的序列化
      Iterable<String> simpleListField =
          fields.entries.where((f) => _isSimpleList(f.value)).map((kv) {
        return '\t\t${kv.key}=${kv.value}.from(json[\'${kv.key}\'])';
      });

      // 对象列表类型需要调用自己类的fromJson，完成自身的序列化
      Iterable<String> objectListField =
          fields.entries.where((f) => _isObjectList(f.value)).map((kv) {
        return "\t\t${kv.key}=(json['${kv.key}'] as List)?.map((l)=>${_getItemType(kv.value)}.fromJson(l))?.toList()";
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
    var pre = '\tMap <String, dynamic> toJson() => {';
    var post = '\t};';
    if (hasValue(fields)) {
      Iterable<String> simpleField = fields.entries
          .where((f) => _isSimple(f.value))
          .map((kv) => '\t\t\'${kv.key}\':${kv.key}');

      Iterable<String> objectField = fields.entries
          .where((f) => _isObject(f.value))
          .map((kv) => '\t\t\'${kv.key}\':${kv.key}?.toJson()');

      Iterable<String> simpleListField = fields.entries
          .where((f) => _isSimpleList(f.value))
          .map((kv) => '\t\t\'${kv.key}\':${kv.key}');

      Iterable<String> objectListField = fields.entries
          .where((f) => _isObjectList(f.value))
          .map((kv) =>
              "\t\t\'${kv.key}':${kv.key}?.map((it)=>it.toJson())?.toList()");

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
        return '\t${kv.value} ${kv.key}';
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
    for (var child in children) {
      classes.add(child.toString());
    }

    // 9. success
    return classes.join('\n\n');
  }
}

/// Is the type of [key] primary type
_isSimple(String key) {
  return ['bool', 'String', 'num'].contains(key);
}

/// Is the type of [key] list
_isList(String key) {
  return key.startsWith('List<');
}

_getItemType(String key) {
  if (!_isList(key)) {
    return key;
  }
  key = key.replaceAll('List<', '');
  var lastIndex = key.lastIndexOf('>');
  var type = key.substring(0, lastIndex);
  return type;
}

_isSimpleList(String key) {
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

_isObjectList(String key) {
  return _isList(key) && !_isSimpleList(key);
}

_isObject(String key) {
  return !_isSimple(key) && !_isList(key);
}
