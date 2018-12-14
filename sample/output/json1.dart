class Json1 {
  num result;
  String msg;
  Json1({this.result, this.msg});

  Json1.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        msg = json['msg'];
  Map<String, dynamic> toJson() => {'result': result, 'msg': msg};
}
