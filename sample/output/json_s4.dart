import 'package:json_annotation/json_annotation.dart';
part 'json_s4.g.dart';

@JsonSerializable()
class JsonS4 {
  num id;
  String name;
  List<ImagesEntity> images;
  JsonS4({this.id, this.name, this.images});

  factory JsonS4.fromJson(Map<String, dynamic> json) => _$JsonS4FromJson(json);
  Map<String, dynamic> toJson() => _$JsonS4ToJson(this);
}

@JsonSerializable()
class ImagesEntity {
  num id;
  String imageName;
  ImagesEntity({this.id, this.imageName});

  factory ImagesEntity.fromJson(Map<String, dynamic> json) =>
      _$ImagesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesEntityToJson(this);
}
