

/// 文件全路径，计算目录
String getDir(String fullPath) {
  var lastIndexOf = fullPath.lastIndexOf('/');
  if (lastIndexOf != -1) {
    return fullPath.substring(0, lastIndexOf + 1);
  }
  return fullPath;
}


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
    return 'null';
  } else {
    return 'Object';
  }
}

/// 将首字母大写
String capitalize(String k) {
  if(k != null && k.length>0) {
    return k[0].toUpperCase()+k.substring(1);
  }
  return k;
}

/// 驼峰转dash
String camel2dash(String k) {
  var codeUnits = k.codeUnits;
  Set<int> upper = new Set();
  List<String> parts = [];
  String ret = '';
  int start = 0;

  for (int i = 0; i < codeUnits.length; i++) {
    var c = codeUnits[i];
    if(isUpperAZ(c)) {
      upper.add(i);
      if(i>0) {
        ret += k.substring(start, i);
        ret += '_';
        start = i;
      }
    }
  }
  ret += k.substring(start);
  return ret.toLowerCase();
}

bool isUpperAZ(int c) {
  return c >= 64 && c <= 90;
}
