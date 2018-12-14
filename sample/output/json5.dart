class Json5 {
  List<DatasEntity> datas;
  Json5({this.datas});

  Json5.fromJson(Map<String, dynamic> json)
      : datas = (json['datas'] as List)
            ?.map((l) => DatasEntity.fromJson(l))
            ?.toList();
  Map<String, dynamic> toJson() =>
      {'datas': datas?.map((it) => it.toJson())?.toList()};
}

class DatasEntity {
  num albumId;
  num id;
  String title;
  String url;
  String thumbnailUrl;
  DatasEntity({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  DatasEntity.fromJson(Map<String, dynamic> json)
      : albumId = json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'];
  Map<String, dynamic> toJson() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl
      };
}
