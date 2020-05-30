/// 获取类型v的类型，对应于json的六种类型
String getType(dynamic v) {
  if (v is String) {
    return 'String';
  } else if (v is num) {
    return 'num';
  } else if (v is bool) {
    return 'bool';
  } else if (v is List) {
    return 'List';
  } else if (v == null) {
    return 'dynamic';
  } else {
    return 'Object';
  }
}

/// 将首字母大写
String capitalize(String k) {
  if (k != null && k.isNotEmpty) {
    return k[0].toUpperCase() + k.substring(1);
  }
  return k;
}

/// 将下划线风格转驼峰
String underscore2Camel(String text) {
  var exp = RegExp(r'(?<=[a-z])(_[a-z])');
  var result = text.replaceAllMapped(
      exp, (Match m) => (capitalize(m.group(0).substring(1))));
  return result;
}

/// 驼峰转dash
String camel2underscore(String k) {
  var codeUnits = k.codeUnits;
  var upper = <dynamic>{};
  var ret = '';
  var start = 0;

  for (var i = 0; i < codeUnits.length; i++) {
    var c = codeUnits[i];
    if (isUpperAZ(c)) {
      upper.add(i);
      if (i > 0) {
        ret += k.substring(start, i);
        ret += '_';
        start = i;
      }
    }
  }
  ret += k.substring(start);
  return ret.toLowerCase();
}

/// Determine whether ASCII corresponding to an integer value is a capital letter?
bool isUpperAZ(int c) {
  return c >= 64 && c <= 90;
}

/// Print [info] when [b] is true.
void printWhen(info, b) {
  if (b) {
    print(info);
  }
}

/// True if value == null or value has no data.
bool hasValue(dynamic value) {
  return value?.isNotEmpty ?? false;
}
