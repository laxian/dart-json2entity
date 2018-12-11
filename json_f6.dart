class JsonF6 {
	String message;
	List<DataEntity> data;
	JsonF6({
		this.message,
		this.data
	});

	JsonF6.fromJson(Map < String, dynamic > json):
		message=json['message'],
		data=(json['data'] as List)?.map((l)=>DataEntity.fromJson(l))?.toList();
	Map <String, dynamic> toJson() => {
		'message':message,
		'data':data?.map((it)=>it.toJson())?.toList()
	};
}

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

	DataEntity.fromJson(Map < String, dynamic > json):
		title=json['title'],
		gallary_flag=json['gallary_flag'],
		article_url=json['article_url'],
		cover_image_url=json['cover_image_url'],
		gallery_image_count=json['gallery_image_count'],
		image_list=(json['image_list'] as List)?.map((l)=>Image_listEntity.fromJson(l))?.toList();
	Map <String, dynamic> toJson() => {
		'title':title,
		'gallary_flag':gallary_flag,
		'article_url':article_url,
		'cover_image_url':cover_image_url,
		'gallery_image_count':gallery_image_count,
		'image_list':image_list?.map((it)=>it.toJson())?.toList()
	};
}

class Image_listEntity {
	String url;
	Image_listEntity({
		this.url
	});

	Image_listEntity.fromJson(Map < String, dynamic > json):
		url=json['url'];
	Map <String, dynamic> toJson() => {
		'url':url
	};
}