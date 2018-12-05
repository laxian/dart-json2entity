import 'json_serializable_clazz.dart';
import 'utils.dart';

main(List<String> args) {
  // test_hasValue();

  // test ClassMaker
  // var base = Clazz('Base',{'result':'int'} ,['@JsonSerializable()']);
  // print(base.toString());
  // var cm = Clazz('MyModel',{'age':'String'} ,['@JsonSerializable()'], base);
  // print(cm.toString());

  // var cz = Clazz.fromJson('{"result":1,"msg":"ok","data":{"age":18,"friends":[1,2]}}');
  var cz = JsonSerializableClazz.fromJson(
      '{"result":1,"msg":"ok","data":{"forceType":1,"title":"update found","message":"please update","url":"www.baidu.com","inner":{"sth":"good"}}}');
  print(cz.toString());
}

void test_hasValue() {
  print(hasValue(null));
  print(hasValue(''));
  print(hasValue('abc'));
  print(hasValue([]));
  print(hasValue([1]));
  print(hasValue({}));
  print(hasValue({"result": 1}));
}
