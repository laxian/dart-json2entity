import 'package:json_annotation/json_annotation.dart';
part 'json_s6.g.dart';

@JsonSerializable()
class JsonS6 {
	String message;
	List<DataEntity> data;
	JsonS6({
		this.message,
		this.data
	});

factory JsonS6.fromJson(Map<String, dynamic> json) => _$JsonS6FromJson(json);
Map<String, dynamic> toJson() => _$JsonS6ToJson(this);
}

@JsonSerializable()
class DataEntity {
	String title;
	num gallary_flag;
	List<Image_listEntity> image_list;
	String article_url;
	String cover_image_url;
	num gallery_image_count;
	DataEntity({
		this.title,
		this.gallary_flag,
		this.image_list,
		this.article_url,
		this.cover_image_url,
		this.gallery_image_count
	});

factory DataEntity.fromJson(Map<String, dynamic> json) => _$DataEntityFromJson(json);
Map<String, dynamic> toJson() => _$DataEntityToJson(this);
}

@JsonSerializable()
class Image_listEntity {
	String url;
	Image_listEntity({
		this.url
	});

factory Image_listEntity.fromJson(Map<String, dynamic> json) => _$Image_listEntityFromJson(json);
Map<String, dynamic> toJson() => _$Image_listEntityToJson(this);
}