/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
class ToutiaoModel {
ToutiaoModel({this.has_more,this.message,this.data,this.next,});
  bool has_more;
  String message;
  List<DataEntity> data;
  NextModel next;
ToutiaoModel.fromJson(Map<String, dynamic> json): 
has_more = json['has_more'],
message = json['message'],
data = json['data'],
next = json['next'];Map<String, dynamic> toJson() =>
{
'has_more': has_more,
'message': message,
'data': data,
'next': next
};
}

class DataEntity {
DataEntity({this.image_url,this.single_mode,this.middle_mode,this.more_mode,this.tag,this.chinese_tag,this.tag_url,this.title,this.label,this.source,this.group_source,this.has_gallery,this.media_url,this.media_avatar_url,this.image_list,this.gallary_image_count,this.source_url,this.article_genre,this.item_id,this.is_feed_ad,this.gallary_flag,this.behot_time,this.comments_count,this.group_id,this.middle_image,});
  String image_url;
  bool single_mode;
  bool middle_mode;
  bool more_mode;
  String tag;
  String chinese_tag;
  String tag_url;
  String title;
  List<String> label;
  String source;
  num group_source;
  bool has_gallery;
  String media_url;
  String media_avatar_url;
  List<Image_listEntity> image_list;
  num gallary_image_count;
  String source_url;
  String article_genre;
  String item_id;
  bool is_feed_ad;
  num gallary_flag;
  num behot_time;
  num comments_count;
  String group_id;
  String middle_image;
DataEntity.fromJson(Map<String, dynamic> json): 
image_url = json['image_url'],
single_mode = json['single_mode'],
middle_mode = json['middle_mode'],
more_mode = json['more_mode'],
tag = json['tag'],
chinese_tag = json['chinese_tag'],
tag_url = json['tag_url'],
title = json['title'],
label = json['label'],
source = json['source'],
group_source = json['group_source'],
has_gallery = json['has_gallery'],
media_url = json['media_url'],
media_avatar_url = json['media_avatar_url'],
image_list = json['image_list'],
gallary_image_count = json['gallary_image_count'],
source_url = json['source_url'],
article_genre = json['article_genre'],
item_id = json['item_id'],
is_feed_ad = json['is_feed_ad'],
gallary_flag = json['gallary_flag'],
behot_time = json['behot_time'],
comments_count = json['comments_count'],
group_id = json['group_id'],
middle_image = json['middle_image'];Map<String, dynamic> toJson() =>
{
'image_url': image_url,
'single_mode': single_mode,
'middle_mode': middle_mode,
'more_mode': more_mode,
'tag': tag,
'chinese_tag': chinese_tag,
'tag_url': tag_url,
'title': title,
'label': label,
'source': source,
'group_source': group_source,
'has_gallery': has_gallery,
'media_url': media_url,
'media_avatar_url': media_avatar_url,
'image_list': image_list,
'gallary_image_count': gallary_image_count,
'source_url': source_url,
'article_genre': article_genre,
'item_id': item_id,
'is_feed_ad': is_feed_ad,
'gallary_flag': gallary_flag,
'behot_time': behot_time,
'comments_count': comments_count,
'group_id': group_id,
'middle_image': middle_image
};
}

class NextModel {
NextModel({this.max_behot_time,});
  num max_behot_time;
NextModel.fromJson(Map<String, dynamic> json): 
max_behot_time = json['max_behot_time'];Map<String, dynamic> toJson() =>
{
'max_behot_time': max_behot_time
};
}

class Image_listEntity {
Image_listEntity({this.url,});
  String url;
Image_listEntity.fromJson(Map<String, dynamic> json): 
url = json['url'];Map<String, dynamic> toJson() =>
{
'url': url
};
}

