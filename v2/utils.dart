/// 获取类型v的类型，对应于json的六种类型
getType(dynamic v) {
  if (v is String) {
    return 'String';
  } else if (v is num) {
    return 'num';
  } else if (v is bool) {
    return 'bool';
  } else if (v is List) {
    return 'List';
  } else if (v == null) {
    return 'String';
  } else {
    return 'Object';
  }
}

hasValue(dynamic value) {
  return value?.isNotEmpty ?? false;
}
