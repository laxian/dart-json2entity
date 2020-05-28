import 'dart:convert';
import '../json2entity.dart';
import 'utils.dart';
import 'clazz.dart';

class JsonSerializableClazz extends Clazz {
  String _INDENT2 = '  '; // _INDENT2 == TWO SAPCE
  String JSONKEY_PREFIX = "@JsonKey(name: 'HOLDER')";
  bool camelize = false;

  /// json_serializable annotation.
  static const String JS_DECOR = '@JsonSerializable()';

  JsonSerializableClazz(
      String name, Map<String, String> fields, List<String> decorators)
      : super(name, fields, decorators);

  factory JsonSerializableClazz.fromJson(String jsonStr,
      {String key, bool camelize}) {
    var jobj;
    try {
      jobj = zip(jsonDecode(jsonStr));
    } on Exception catch (e) {
      throw FormatException(
          'Input Json Format Error! ${(e as FormatException).message}');
    }
    if (jobj is Map) {
      return JsonSerializableClazz.fromMap(jobj, key: key, camelize: camelize);
    }
    return JsonSerializableClazz.fromList(jobj, key: key, camelize: camelize);
  }

  factory JsonSerializableClazz.fromMap(Map<String, dynamic> jsonMap,
      {String key, bool camelize}) {
    assert(jsonMap != null);
    var entry =
        new MapEntry<String, Map<String, dynamic>>(key ?? 'AutoModel', jsonMap);
    return JsonSerializableClazz.fromMapEntry(entry, camelize: camelize);
  }

  factory JsonSerializableClazz.fromList(List<dynamic> jsonList,
      {String key, bool camelize}) {
    assert(jsonList != null);
    assert(jsonList.isNotEmpty);

    String default_key = 'datas';
    var newMap = <String, dynamic>{};
    newMap[default_key] = jsonList;

    return JsonSerializableClazz.fromMap(newMap, key: key, camelize: camelize);
  }

  JsonSerializableClazz.fromMapEntry(
      MapEntry<String, Map<String, dynamic>> entry,
      {bool camelize})
      : camelize = camelize ?? false,
        super.fromMapEntry(entry) {
    // addHeader('import \'package:json_annotation/json_annotation.dart\';');
    addDecorator(JS_DECOR);
  }

  @override
  String toString() {
    for (Clazz item in children) {
      item.addDecorator(JS_DECOR);
    }
    return super.toString();
  }

  /// Build child class Recursively.
  @override
  Clazz buildChildClazz(Map<String, dynamic> curr, {String key}) {
    return JsonSerializableClazz.fromMap(curr, key: capitalize(key));
  }

  /// Override from super. Build json_serializable style fromJson method.
  @override
  String buildFromJson() {
    return '${_INDENT2}factory ${name}.fromJson(Map<String, dynamic> json) => _\$${name}FromJson(json);';
  }

  /// Override from super. Build json_serializable style toJson method.
  @override
  String buildToJson() {
    return '${_INDENT2}Map<String, dynamic> toJson() => _\$${name}ToJson(this);';
  }

  /// Build field declaration
  @override
  String buildFieldDeclare({String type, String name}) {
    if (!name.contains('_') || !camelize) {
      return super.buildFieldDeclare(type: type, name: name);
    }
    var jsonKeyLine = JSONKEY_PREFIX.replaceFirst("HOLDER", name);
    return '${_INDENT2}$jsonKeyLine\n${_INDENT2}${type} ${buildFieldInConstructor(name: name)}';
  }

  /// Build field declaration
  String buildFieldInConstructor({String name}) {
    if (!name.contains('_') || !camelize) return name;
    return underscore2Camel(name.toLowerCase());
  }
}
