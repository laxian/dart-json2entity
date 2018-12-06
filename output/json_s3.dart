import 'package:json_annotation/json_annotation.dart';
part 'json_s3.g.dart';

@JsonSerializable()
class JsonS3 {
	String city;
	List<String> streets;
	JsonS3({
		this.city,
		this.streets
	});

factory JsonS3.fromJson(Map<String, dynamic> json) => _$JsonS3FromJson(json);
Map<String, dynamic> toJson() => _$JsonS3ToJson(this);
}