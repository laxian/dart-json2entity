class JsonF3 {
	String city;
	List<String> streets;
	JsonF3({
		this.city,
		this.streets
	});

	JsonF3.fromJson(Map < String, dynamic > json):
		city=json['city'],
		streets=List<String>.from(json['streets']);
	Map <String, dynamic> toJson() => {
		'city':city,
		'streets':streets
	};
}