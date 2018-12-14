class Json4 {
  num id;
  String name;
  List<ImagesEntity> images;
  Json4({this.id, this.name, this.images});

  Json4.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        images = (json['images'] as List)
            ?.map((l) => ImagesEntity.fromJson(l))
            ?.toList();
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'images': images?.map((it) => it.toJson())?.toList()
      };
}

class ImagesEntity {
  num id;
  String imageName;
  ImagesEntity({this.id, this.imageName});

  ImagesEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageName = json['imageName'];
  Map<String, dynamic> toJson() => {'id': id, 'imageName': imageName};
}
