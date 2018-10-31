

class ConstStr {

  static List<String> json_serializable_insert_file_header_strs = [
    "import 'package:json_annotation/json_annotation.dart';\n\n",
    "part '{Name}.g.dart';\n\n",'''
/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
'''
  ];

  static String json_serializable_insert_before_class = '@JsonSerializable()\n';
  static String json_serializable_insert_into_class = """
  factory {Name}.fromJson(Map<String, dynamic> json) => _\${Name}FromJson(json);
  Map<String, dynamic> toJson() => _\${Name}ToJson(this);\n""";
}