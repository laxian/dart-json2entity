import 'package:json_annotation/json_annotation.dart';
part 'json_s1.g.dart';

@JsonSerializable()
class JsonS1 {
  num result;
  String msg;
  JsonS1({this.result, this.msg});

  factory JsonS1.fromJson(Map<String, dynamic> json) => _$JsonS1FromJson(json);
  Map<String, dynamic> toJson() => _$JsonS1ToJson(this);
}
