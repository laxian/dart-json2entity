import '../output/city.dart';
import '../output/object_list.dart';
import 'dart:convert';

main(List < String > args) {

  testSimpleList();

  testObjectList();
}

void testObjectList() {
  var json = '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
  var obj = ObjectList.fromJson(jsonDecode(json));
  print(obj.toJson());
}

void testSimpleList() {
  var json = '{"city":"Mumbai","streets":["address1","address2"]}';
  var city = City.fromJson(jsonDecode(json));
  print(city.toJson());
}