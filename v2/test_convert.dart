import 'clazz.dart';
import '../utils.dart';
import 'json_serializable_clazz.dart';

// 5种不同类型json测试用例，分别是
// 简单无嵌套json
// 嵌套json
// 嵌套简单列表json
// 嵌套对象列表json
// 对象列表json
var json1 = '{"result":1,"msg":"ok"}';
var json2 = '{"result":1,"msg":"ok","data":{"answer":"A"}}';
var json3 = '{"city":"Mumbai","streets":["address1","address2"]}';
var json4 = '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
var json5 = '[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]';
var json6 = '{"message":"success","data":[{"title":"父亲车祸母亲失踪女孩急等骨髓救命48岁姑父为其寻母8年未间断","gallary_flag":2,"image_list":[{"url":"//p99.pstatp.com/list/364x360/pgc-image/9c14e3a8dd1141bf9e84482ec0a969fd"},{"url":"//p3.pstatp.com/list/272x178/pgc-image/fc93fe97e6254a00a8c54782c368a66a"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/51ea0b3d56484e64bb4173fb40d88941"}],"article_url":"/group/6631418812048605700/","cover_image_url":"//p99.pstatp.com/list/300x170/pgc-image/9c14e3a8dd1141bf9e84482ec0a969fd","gallery_image_count":14},{"title":"清朝12位皇帝真实容貌：道光帝开始脸变小，末代皇帝溥仪如此英俊","gallary_flag":1,"image_list":[{"url":"//p1.pstatp.com/list/640x360/pgc-image/1537076286050672437e773"},{"url":"//p3.pstatp.com/list/pgc-image/1537076286006e0a40f97e3"},{"url":"//p9.pstatp.com/list/pgc-image/1537076334677c121c62849"}],"article_url":"/group/6601692955138851342/","cover_image_url":"//p1.pstatp.com/list/300x170/pgc-image/1537076286050672437e773","gallery_image_count":12},{"title":"全世界最不可思议的十大土豪生活，只有你想不到的，没有做不到的","gallary_flag":1,"image_list":[{"url":"//p3.pstatp.com/list/640x360/pgc-image/15379270782881eb823c455"},{"url":"//p3.pstatp.com/list/pgc-image/1537927078358b5fb372180"},{"url":"//p3.pstatp.com/list/pgc-image/1537927078196fb83166b4a"}],"article_url":"/group/6605348757426930189/","cover_image_url":"//p3.pstatp.com/list/300x170/pgc-image/15379270782881eb823c455","gallery_image_count":10},{"title":"这3个景点都取消了门票费，免费让游客参观，你会考虑去一次吗？","gallary_flag":2,"image_list":[{"url":"//p9.pstatp.com/list/364x360/pgc-image/c3f7ca96ebe24b5380c9ead22f7dcc2b"},{"url":"//p9.pstatp.com/list/272x178/pgc-image/23aa8619a4284c1b88e92c5fe2a9d85e"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/ce7bcc2f39fc477db02e3f122272659e"}],"article_url":"/group/6624419395680600583/","cover_image_url":"//p9.pstatp.com/list/300x170/pgc-image/c3f7ca96ebe24b5380c9ead22f7dcc2b","gallery_image_count":8},{"title":"这三位明星背景强大，几乎没人敢惹","gallary_flag":2,"image_list":[{"url":"//p99.pstatp.com/list/dfic-imagehandler/0a786347-bc90-4db1-b14e-4e569344e402"},{"url":"//p1.pstatp.com/list/dfic-imagehandler/9fb8f421-0c9c-455c-a7fc-2a9e9d90cf80"},{"url":"//p3.pstatp.com/list/dfic-imagehandler/ef3b09a3-b4bb-4463-bb54-d72163d98559"}],"article_url":"/group/6630935274056581636/","cover_image_url":"//p99.pstatp.com/list/dfic-imagehandler/0a786347-bc90-4db1-b14e-4e569344e402","gallery_image_count":3},{"title":"古城修缮：复建中的明太原县城，晋阳古城遗址上的古城文脉传承","gallary_flag":1,"image_list":[{"url":"//p9.pstatp.com/list/640x360/b71f00046c2f82588541"},{"url":"//p3.pstatp.com/list/b71f00046c302e6b6f9d"},{"url":"//p1.pstatp.com/list/b72400031bb4f9fee5bd"}],"article_url":"/group/6601406546641420803/","cover_image_url":"//p9.pstatp.com/list/300x170/b71f00046c2f82588541","gallery_image_count":6},{"title":"像瓜不是瓜，像藕不是藕，农村夫妻祖传手艺制作稀罕物，日赚1000","gallary_flag":1,"image_list":[{"url":"//p99.pstatp.com/list/640x360/pgc-image/15368358594420267044bea"},{"url":"//p3.pstatp.com/list/pgc-image/153683585801878fe338032"},{"url":"//p3.pstatp.com/list/pgc-image/15368358580542cd67b1121"}],"article_url":"/group/6600699719456915976/","cover_image_url":"//p99.pstatp.com/list/300x170/pgc-image/15368358594420267044bea","gallery_image_count":9},{"title":"活佛眼睛（二）","gallary_flag":2,"image_list":[{"url":"//p3.pstatp.com/list/364x360/pgc-image/75e16a0f519b45f0a527b3f9228150ef"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/3154065bef234dfbbc0cd90ac8b765f8"},{"url":"//p99.pstatp.com/list/272x178/pgc-image/7fe76b56fa844f46b4088ba62bf5e118"}],"article_url":"/group/6631057751093035534/","cover_image_url":"//p3.pstatp.com/list/300x170/pgc-image/75e16a0f519b45f0a527b3f9228150ef","gallery_image_count":3}]}';

main(List < String > args) {
  // testHasValue();
  testConvert();
  testConvertJsonSerializableSupport();
}

void testConvertJsonSerializableSupport() {
  var clazz1 = JsonSerializableClazz.fromJson(json1);
  print(clazz1.toString());
  var clazz2 = JsonSerializableClazz.fromJson(json2);
  print(clazz2.toString());
  var clazz3 = JsonSerializableClazz.fromJson(json3);
  print(clazz3.toString());
  var clazz4 = JsonSerializableClazz.fromJson(json4);
  print(clazz4.toString());
  var clazz5 = JsonSerializableClazz.fromJson(json5);
  print(clazz5.toString());
  var clazz6 = JsonSerializableClazz.fromJson(json6);
  print(clazz6.toString());
}

void testConvert() {
  var clazz1 = Clazz.fromJson(json1);
  print(clazz1.toString());
  var clazz2 = Clazz.fromJson(json2);
  print(clazz2.toString());
  var clazz3 = Clazz.fromJson(json3);
  print(clazz3.toString());
  var clazz4 = Clazz.fromJson(json4);
  print(clazz4.toString());
  var clazz5 = Clazz.fromJson(json5);
  print(clazz5.toString());
  var clazz6 = JsonSerializableClazz.fromJson(json6);
  print(clazz6.toString());
}

void testHasValue() {
  print(hasValue(null));
  print(hasValue(''));
  print(hasValue('abc'));
  print(hasValue([]));
  print(hasValue([1]));
  print(hasValue({}));
  print(hasValue({
    "result": 1
  }));
}