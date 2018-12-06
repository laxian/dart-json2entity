import 'package:json_annotation/json_annotation.dart';
part 'json_s5.g.dart';

@JsonSerializable()
class JsonS5 {
	List<DatasEntity> datas;
	JsonS5({
		this.datas
	});

factory JsonS5.fromJson(Map<String, dynamic> json) => _$JsonS5FromJson(json);
Map<String, dynamic> toJson() => _$JsonS5ToJson(this);
}

@JsonSerializable()
class DatasEntity {
	num albumId;
	num id;
	String title;
	String url;
	String thumbnailUrl;
	DatasEntity({
		this.albumId,
		this.id,
		this.title,
		this.url,
		this.thumbnailUrl
	});

factory DatasEntity.fromJson(Map<String, dynamic> json) => _$DatasEntityFromJson(json);
Map<String, dynamic> toJson() => _$DatasEntityToJson(this);
}