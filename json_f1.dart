class JsonF1 {
	num result;
	String msg;
	JsonF1({
		this.result,
		this.msg
	});

	JsonF1.fromJson(Map < String, dynamic > json):
		result=json['result'],
		msg=json['msg'];
	Map <String, dynamic> toJson() => {
		'result':result,
		'msg':msg
	};
}