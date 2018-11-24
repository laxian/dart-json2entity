/**
 * auto generate by json2bean
 * Author zhuoweixian
 */
class AppUpdateCheck {
AppUpdateCheck({this.result,this.msg,this.data,});
  num result;
  String msg;
  DataModel data;
AppUpdateCheck.fromJson(Map<String, dynamic> json): 
result = json['result'],
msg = json['msg'],
data = json['data'];Map<String, dynamic> toJson() =>
{
'result': result,
'msg': msg,
'data': data
};
}

class DataModel {
DataModel({this.forceType,this.title,this.message,this.url,});
  num forceType;
  String title;
  String message;
  String url;
DataModel.fromJson(Map<String, dynamic> json): 
forceType = json['forceType'],
title = json['title'],
message = json['message'],
url = json['url'];Map<String, dynamic> toJson() =>
{
'forceType': forceType,
'title': title,
'message': message,
'url': url
};
}

