import 'dart:io';

import '../utils.dart';

/// convert json to dart PO
/// 思路：
/// 树形遍历json map。将所有Object类型输出class。
/// 添加 json_serializable 支持
/// 未整理
/// by zhouweixian
class EntityWriter {

  bool show_verbose = false;
  // default output dir
  var outpath = getDir(Platform.script.path) + 'bean/';

  // input json object
  Map < String, dynamic > json;

  // 输出model（最外层）的类名和文件名
  String name;

  // 导包信息，作者信息，等文件头部内容，在所有类之前
  List < String > headers = [];

  // 类前的注释或者注解、装饰器
  String decorators;

  // 插入类内部的模板
  String inserts;

  // json中Object对象对应的class string
  List < String > classes = [];

  bool supportJsonSerializable = false;

  setShowVerbose(bool enable) {
    show_verbose = enable;
  }

  setSupportJsonSerialization(bool support) {
    supportJsonSerializable = support;
  }

  setName(String name) {
    this.name = name;
  }

  setJson(dynamic j) {
    if (j is List) {
      assert(j.length > 0);
      json = j[0];
    } else if (j is Map) {
      json = j;
    } else {
      throw 'setJson can only be map or list';
    }
  }

  setDecorators(String str) {
    this.decorators = str;
  }

  setInserts(String str) {
    this.inserts = str;
  }

  addHeaders(List < String > strs) {
    var list =
      strs.map((e) => e.replaceAll('{Name}', camel2dash(name))).toList();
    headers.addAll(list);
  }

  setOutputDir(String dir) {
    outpath = dir;
  }

  convert() {

    printWhen('Begin convert: $name', show_verbose);

    Map < String, Map < String, dynamic >> pending = {};
    pending[name] = json;

    while (pending.entries.length > 0) {
      var name = pending.entries.elementAt(0).key;
      var Name = capitalize(name);
      var curr = pending.remove(name);

      String s = 'class $Name {\n';

      // 类前一行的装饰，比如注解，装饰器
      if (decorators != null && decorators.length > 0) {
        s = decorators + s;
      }

      // 添加构造函数
      s += getConstructor(curr, name);

      // fields: eg. String name;...num age;
      curr.forEach((k, v) {
        var K = capitalize(k);
        var childName = '${K}Model';

        if (v is Map) {
          pending[childName] = v;
          s += '  ${childName} $k;\n';
        } else if (v is List) {
          var childName = '${K}Entity';
          if (v.length > 0) {
            var value0 = v[0];
            if (value0 is Map)
              pending[childName] = v[0];
            else
              childName = getType(v[0]);
          } else {
            pending[childName] = {};
          }
          s += '  List<${childName}> $k;\n';
        } else {
          // basic type
          var t = getType(v);
          s += '  $t $k;\n';
        }
      });

      s += getInsertBody(name, curr);

      s += '}\n\n';
      classes.add(s);
    }

    // 确保路径存在
    var directory = new Directory(outpath);
    directory.createSync(recursive: true);

    var fullPath = new File(outpath + camel2dash(name) + '.dart');
    var sink = fullPath.openWrite();

    for (var value in headers) {
      sink.write(value);
    }

    for (var value in classes) {
      sink.write(value);
    }
    sink.close();

    printWhen('Convert: $name successful!', show_verbose);
  }

  /// 生成构造函数
  String getConstructor(Map < String, dynamic > m, String name) {
    // LoginModel({});
    var Name = capitalize(name);
    var begin = '$Name({';
    var mid = '';
    m.forEach((k, v) {
      mid += 'this.$k,';
    });

    var end = '});\n';

    if (mid.length > 0) return begin + mid + end;

    return '$Name();\n';
  }

  String getFromJsonPart(String name, Map < String, dynamic > m) {
    var ret = '\n\t$name.fromJson(Map<String, dynamic> json)';
    if(m==null || m.length == 0) {
      return '$ret;';
    }
    List < String > fieldList = [];
    m.forEach((k, v) {
      fieldList.add("\t\t$k = json['$k']");
    });
    var joined = fieldList.join(',\n');

    return '${ret}:\n$joined;';
  }

  String getToJsonPart(String name, Map < String, dynamic > m) {
    var pre = '\n\tMap<String, dynamic> toJson() => {';
    List < String > fieldList = [];
    m.forEach((k, v) {
      fieldList.add("\t\t'$k': $k");
    });
    var joined = fieldList.join(',\n');

    return "$pre\n$joined\n\t};\n";
  }

  String getInsertBody(String name, curr) {
    var Name = capitalize(name);
    if (supportJsonSerializable) {
      return inserts.replaceAll('{Name}', Name);
    }
    String result = '';
    result += getFromJsonPart(Name, curr);
    result += getToJsonPart(Name, curr);
    return result;
  }
}