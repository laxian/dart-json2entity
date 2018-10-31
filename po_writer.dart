import 'dart:io';

import 'package:aixue4/code-generate/flutter-gsonformat/utils.dart';



/// convert json to dart PO
/// 思路：
/// 树形遍历json map。将所有Object类型输出class。
/// 添加 json_serializable 支持
/// 未整理
/// by zhouweixian
class poWriter {

  // default output dir
  var outpath = getDir(Platform.script.path) + 'bean/';
  // input json object
  Map<String, dynamic> json;
  // 输出model（最外层）的类名和文件名
  String name;

  // 导包信息，作者信息，等文件头部内容，在所有类之前
  List<String> headerStrs = [];

  // json中Object对象对应的class string
  List<String> classStrs = [];

  // 类前的注释或者注解、装饰器
  String beforeClassStr;

  // 插入类内部的模板
  String intertStr
  ;
  Map<String, Map<String, String>> intertStrs = {};

  addClassInsert(String template, Map<String, String> replace) {
    intertStrs[template] = replace;
  }

  setName(String name){
    this.name = name;
  }

  setJson(Map<String, dynamic> j) {
    json =j;
  }

  setBeforeClassStr(String str) {
    this.beforeClassStr = str;
  }

  setInsertStr(String str) {
    this.intertStr = str;
  }

  addHeaderStrs(List<String> strs) {
    var list = strs.map((e)=>e.replaceAll('{Name}', camel2dash(name))).toList();
    headerStrs.addAll(list);
  }

  setOutputDir(String dir) {
    outpath = dir;
  }

  convert() {
    Map<String, Map<String, dynamic>> pending = {};
    pending[name] = json;

    while(pending.entries.length > 0) {
      var name = pending.entries.elementAt(0).key;
      var Name = capitalize(name);
      var m = pending.remove(name);

      String s = 'class $Name {\n';

      // 类前一行的装饰，比如注解，装饰器
      if(beforeClassStr != null && beforeClassStr.length > 0) {
        s = beforeClassStr + s;
      }

      // 添加构造函数
      s += getConstructor(m, name);

      m.forEach((k,v){
        var K = capitalize(k);
        var childName = '${K}Model';
        if(v is Map) {
          pending[childName]=v;
          s += '  ${childName} $k;\n';
        } else if (v is List) {
          var K = capitalize(k);
          var childName = '${K}Entity';
          if(v.length > 0) {
            pending[childName]=v[0];
          } else {
            pending[childName]={};
          }
          s += '  List<${childName}> $k;\n';
        } else {
          // basic type
          var t = getType(v);
          s += '  $t $k;\n';
        }
      });

      s += replacePlaceHolder('{Name}', Name);

      s += '}\n\n';
      classStrs.add(s);
    }

    // 确保路径存在
    var directory = new Directory(outpath);
    directory.createSync(recursive: true);

    var fullPath = new File(outpath + camel2dash(name) + '.dart');
    var sink = fullPath.openWrite();

    for (var value in headerStrs) {
      sink.write(value);
    }

    for (var value in classStrs) {
      sink.write(value);
    }
    sink.close();
  }

  /// 生成构造函数
  String getConstructor(Map<String, dynamic> m, String name) {
    // LoginModel({});
    var Name = capitalize(name);
    var begin = '$Name({';
    var mid = '';
    m.forEach((k, v) {
      var typev = getType(v);
      mid += '$typev $k,';
    });

    var end = '});\n';

    if(mid.length > 0)
      return begin + mid + end;

    return '$Name();\n';
  }

  String replacePlaceHolder(String parten, String name) {
    return intertStr.replaceAll(parten, name);
  }

  String replaceAllInMap(String template, Map<String, String> kv) {
    var ret = '';
    if(kv.isNotEmpty) {
      kv.forEach((k,v){
        ret = template.replaceAll(k, v);
      });
    }
    return ret;
  }

  String computeInsert() {
    var ret = '';
    if(intertStrs.isNotEmpty) {
      intertStrs.forEach((k,v){
        ret += replaceAllInMap(k, v);
      });
    } else {
      return ret;
    }
  }
}
