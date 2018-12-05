import 'dart:convert';

import '../utils.dart';
import 'clazz.dart';

class JsonSerializableClazz extends Clazz {
  static const String JS_DECOR = '@JsonSerializable()';

  JsonSerializableClazz(
      String name, Map<String, String> fields, List<String> decorators)
      : super(name, fields, decorators);

  factory JsonSerializableClazz.fromJson(String jsonStr, {String key}) {
    var jobj = jsonDecode(jsonStr);
    if (jobj is Map) {
      return JsonSerializableClazz.fromMap(jobj, key: key);
    }
    return JsonSerializableClazz.fromList(jobj, key: key);
  }

  factory JsonSerializableClazz.fromMap(Map<String, dynamic> jsonMap,
      {String key}) {
    assert(jsonMap != null);
    var entry =
        new MapEntry<String, Map<String, dynamic>>(key ?? 'AutoModel', jsonMap);
    return JsonSerializableClazz.fromMapEntry(entry);
  }

  factory JsonSerializableClazz.fromList(List<dynamic> jsonList,{String key}) {
    assert(jsonList != null);
    assert(jsonList.length > 0);

    String default_key = 'datas';
    var newMap = <String, dynamic>{};
    newMap[default_key] = jsonList;

    return JsonSerializableClazz.fromMap(newMap, key: key);
  }

  JsonSerializableClazz.fromMapEntry(
      MapEntry<String, Map<String, dynamic>> entry)
      : super.fromMapEntry(entry) {
    // addHeader('import \'package:json_annotation/json_annotation.dart\';');
    addDecorator(JS_DECOR);
  }

  @override
  String toString() {
    for (Clazz item in childs) {
      item.addDecorator(JS_DECOR);
    }
    return super.toString();
  }

  @override
  Clazz buildChildClazz(Map<String, dynamic> curr, {String key}) {
    return JsonSerializableClazz.fromMap(curr, key: capitalize(key));
  }

  @override
  String buildFromJson() {
    return 'factory ${name}.fromJson(Map<String, dynamic> json) => _\$${name}FromJson(json);';
  }

  @override
  String buildToJson() {
    return 'Map<String, dynamic> toJson() => _\$${name}ToJson(this);';
  }
}
