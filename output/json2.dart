class Json2 {
	num result;
	String msg;
	DataEntity data;
	Json2({
		this.result,
		this.msg,
		this.data
	});

	Json2.fromJson(Map < String, dynamic > json):
		result=json['result'],
		msg=json['msg'],
		data=DataEntity.fromJson(json['data']);
	Map <String, dynamic> toJson() => {
		'result':result,
		'msg':msg,
		'data':data?.toJson()
	};
}

class DataEntity {
	String answer;
	DataEntity({
		this.answer
	});

	DataEntity.fromJson(Map < String, dynamic > json):
		answer=json['answer'];
	Map <String, dynamic> toJson() => {
		'answer':answer
	};
}