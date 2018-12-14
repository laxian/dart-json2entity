class Json3 {
  String city;
  List<String> streets;
  Json3({this.city, this.streets});

  Json3.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        streets = List<String>.from(json['streets']);
  Map<String, dynamic> toJson() => {'city': city, 'streets': streets};
}
