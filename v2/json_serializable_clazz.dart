import 'dart:convert';

import '../utils.dart';
import 'clazz.dart';

class JsonSerializableClazz extends Clazz {
  static const String JS_DECOR = '@JsonSerializable()';

  JsonSerializableClazz(
      String name, Map<String, String> fields, List<String> decorators)
      : super(name, fields, decorators);

  factory JsonSerializableClazz.fromJson(String jsonStr, {String key}) =>
      JsonSerializableClazz.fromMap(jsonDecode(jsonStr), key: key);

  factory JsonSerializableClazz.fromMap(Map<String, dynamic> jsonMap,
      {String key}) {
    assert(jsonMap != null);
    var entry =
        new MapEntry<String, Map<String, dynamic>>(key ?? 'AutoModel', jsonMap);
    return JsonSerializableClazz.fromMapEntry(entry);
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
  Clazz buildChildClazz(Map curr, {String key}) {
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
