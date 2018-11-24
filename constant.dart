

class ConstStr {

  /// 插入到文件头部的信息
  static List<String> INSERT_HEADER = [
    "import 'package:json_annotation/json_annotation.dart';\n\n",
    "part '{Name}.g.dart';\n\n",'''
/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
'''
  ];

  /// 插入到类前的，注解、装饰器之类的信息
  static String INSERT_DECORATOR = '@JsonSerializable()\n';

  /// 插入到类内部的信息
  static String INSERT_IN_CLASS = """
  factory {Name}.fromJson(Map<String, dynamic> json) => _\${Name}FromJson(json);
  Map<String, dynamic> toJson() => _\${Name}ToJson(this);\n""";
}