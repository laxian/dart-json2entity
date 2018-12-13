import 'dart:convert';
import '../output/json1.dart';
import '../output/json2.dart';
import '../output/json3.dart';
import '../output/json4.dart';
import '../output/json5.dart';
import '../output/json6.dart';
import '../output/json_f1.dart';
import '../output/json_f2.dart';
import '../output/json_f3.dart';
import '../output/json_f4.dart';
import '../output/json_f5.dart';
import '../output/json_f6.dart';
import '../output/json_s1.dart';
import '../output/json_s2.dart';
import '../output/json_s3.dart';
import '../output/json_s4.dart';
import '../output/json_s5.dart';
import '../output/json_s6.dart';


var json1 = '{"result":1,"msg":"ok"}';
var json2 = '{"result":1,"msg":"ok","data":{"answer":"A"}}';
var json3 = '{"city":"Mumbai","streets":["address1","address2"]}';
var json4 = '{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
var json5 = '[{"albumId":1,"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]';
var json6 = '{"message": "success", "data": [{"title": "\u7236\u4eb2\u8f66\u7978\u6bcd\u4eb2\u5931\u8e2a\u5973\u5b69\u6025\u7b49\u9aa8\u9ad3\u6551\u547d 48\u5c81\u59d1\u7236\u4e3a\u5176\u5bfb\u6bcd8\u5e74\u672a\u95f4\u65ad", "gallary_flag": 2, "image_list": [{"url": "//p99.pstatp.com/list/364x360/pgc-image/9c14e3a8dd1141bf9e84482ec0a969fd"}, {"url": "//p3.pstatp.com/list/272x178/pgc-image/fc93fe97e6254a00a8c54782c368a66a"}, {"url": "//p99.pstatp.com/list/272x178/pgc-image/51ea0b3d56484e64bb4173fb40d88941"}], "article_url": "/group/6631418812048605700/", "cover_image_url": "//p99.pstatp.com/list/300x170/pgc-image/9c14e3a8dd1141bf9e84482ec0a969fd", "gallery_image_count": 14}, {"title": "\u6e05\u671d12\u4f4d\u7687\u5e1d\u771f\u5b9e\u5bb9\u8c8c\uff1a\u9053\u5149\u5e1d\u5f00\u59cb\u8138\u53d8\u5c0f\uff0c\u672b\u4ee3\u7687\u5e1d\u6ea5\u4eea\u5982\u6b64\u82f1\u4fca", "gallary_flag": 1, "image_list": [{"url": "//p1.pstatp.com/list/640x360/pgc-image/1537076286050672437e773"}, {"url": "//p3.pstatp.com/list/pgc-image/1537076286006e0a40f97e3"}, {"url": "//p9.pstatp.com/list/pgc-image/1537076334677c121c62849"}], "article_url": "/group/6601692955138851342/", "cover_image_url": "//p1.pstatp.com/list/300x170/pgc-image/1537076286050672437e773", "gallery_image_count": 12}, {"title": "\u5168\u4e16\u754c\u6700\u4e0d\u53ef\u601d\u8bae\u7684\u5341\u5927\u571f\u8c6a\u751f\u6d3b\uff0c\u53ea\u6709\u4f60\u60f3\u4e0d\u5230\u7684\uff0c\u6ca1\u6709\u505a\u4e0d\u5230\u7684", "gallary_flag": 1, "image_list": [{"url": "//p3.pstatp.com/list/640x360/pgc-image/15379270782881eb823c455"}, {"url": "//p3.pstatp.com/list/pgc-image/1537927078358b5fb372180"}, {"url": "//p3.pstatp.com/list/pgc-image/1537927078196fb83166b4a"}], "article_url": "/group/6605348757426930189/", "cover_image_url": "//p3.pstatp.com/list/300x170/pgc-image/15379270782881eb823c455", "gallery_image_count": 10}, {"title": "\u8fd93\u4e2a\u666f\u70b9\u90fd\u53d6\u6d88\u4e86\u95e8\u7968\u8d39\uff0c\u514d\u8d39\u8ba9\u6e38\u5ba2\u53c2\u89c2\uff0c\u4f60\u4f1a\u8003\u8651\u53bb\u4e00\u6b21\u5417\uff1f", "gallary_flag": 2, "image_list": [{"url": "//p9.pstatp.com/list/364x360/pgc-image/c3f7ca96ebe24b5380c9ead22f7dcc2b"}, {"url": "//p9.pstatp.com/list/272x178/pgc-image/23aa8619a4284c1b88e92c5fe2a9d85e"}, {"url": "//p99.pstatp.com/list/272x178/pgc-image/ce7bcc2f39fc477db02e3f122272659e"}], "article_url": "/group/6624419395680600583/", "cover_image_url": "//p9.pstatp.com/list/300x170/pgc-image/c3f7ca96ebe24b5380c9ead22f7dcc2b", "gallery_image_count": 8}, {"title": "\u8fd9\u4e09\u4f4d\u660e\u661f\u80cc\u666f\u5f3a\u5927\uff0c\u51e0\u4e4e\u6ca1\u4eba\u6562\u60f9", "gallary_flag": 2, "image_list": [{"url": "//p99.pstatp.com/list/dfic-imagehandler/0a786347-bc90-4db1-b14e-4e569344e402"}, {"url": "//p1.pstatp.com/list/dfic-imagehandler/9fb8f421-0c9c-455c-a7fc-2a9e9d90cf80"}, {"url": "//p3.pstatp.com/list/dfic-imagehandler/ef3b09a3-b4bb-4463-bb54-d72163d98559"}], "article_url": "/group/6630935274056581636/", "cover_image_url": "//p99.pstatp.com/list/dfic-imagehandler/0a786347-bc90-4db1-b14e-4e569344e402", "gallery_image_count": 3}, {"title": "\u53e4\u57ce\u4fee\u7f2e\uff1a\u590d\u5efa\u4e2d\u7684\u660e\u592a\u539f\u53bf\u57ce\uff0c\u664b\u9633\u53e4\u57ce\u9057\u5740\u4e0a\u7684\u53e4\u57ce\u6587\u8109\u4f20\u627f", "gallary_flag": 1, "image_list": [{"url": "//p9.pstatp.com/list/640x360/b71f00046c2f82588541"}, {"url": "//p3.pstatp.com/list/b71f00046c302e6b6f9d"}, {"url": "//p1.pstatp.com/list/b72400031bb4f9fee5bd"}], "article_url": "/group/6601406546641420803/", "cover_image_url": "//p9.pstatp.com/list/300x170/b71f00046c2f82588541", "gallery_image_count": 6}, {"title": "\u50cf\u74dc\u4e0d\u662f\u74dc\uff0c\u50cf\u85d5\u4e0d\u662f\u85d5\uff0c\u519c\u6751\u592b\u59bb\u7956\u4f20\u624b\u827a\u5236\u4f5c\u7a00\u7f55\u7269\uff0c\u65e5\u8d5a1000", "gallary_flag": 1, "image_list": [{"url": "//p99.pstatp.com/list/640x360/pgc-image/15368358594420267044bea"}, {"url": "//p3.pstatp.com/list/pgc-image/153683585801878fe338032"}, {"url": "//p3.pstatp.com/list/pgc-image/15368358580542cd67b1121"}], "article_url": "/group/6600699719456915976/", "cover_image_url": "//p99.pstatp.com/list/300x170/pgc-image/15368358594420267044bea", "gallery_image_count": 9}, {"title": "\u6d3b\u4f5b\u773c\u775b\uff08\u4e8c\uff09", "gallary_flag": 2, "image_list": [{"url": "//p3.pstatp.com/list/364x360/pgc-image/75e16a0f519b45f0a527b3f9228150ef"}, {"url": "//p99.pstatp.com/list/272x178/pgc-image/3154065bef234dfbbc0cd90ac8b765f8"}, {"url": "//p99.pstatp.com/list/272x178/pgc-image/7fe76b56fa844f46b4088ba62bf5e118"}], "article_url": "/group/6631057751093035534/", "cover_image_url": "//p3.pstatp.com/list/300x170/pgc-image/75e16a0f519b45f0a527b3f9228150ef", "gallery_image_count": 3}]}';
var json7 = '{"has_more":false,"message":"success","data":[{"single_mode":false,"abstract":"穿过大西洋无垠的水面，飞越亚马孙河畔的密林，穿越潘帕斯草原上空的云。二十国集团领导人峰会首次落地南美洲，汇聚了代表着全球2/3人口、近90%生产总值的世界重要经济体领导人，汇聚了万千聚光灯。","middle_mode":false,"more_mode":false,"tag":"news_politics","label":["经济","金融","投资","时政"],"tag_url":"search/?keyword=%E6%97%B6%E6%94%BF","title":"习近平主席出席二十国集团领导人第十三次峰会纪实","chinese_tag":"时政","source":"新华网","group_source":2,"has_gallery":false,"media_url":"/c/user/4377795668/","media_avatar_url":"//p2.pstatp.com/large/3658/7378365093","source_url":"/group/6631720493122601476/","article_genre":"article","is_stick":true,"item_id":"6631720493122601476","is_feed_ad":false,"behot_time":1544081122,"comments_count":3610,"group_id":"6631720493122601476"},{"media_avatar_url":"//p2.pstatp.com/large/9519/925052030","is_feed_ad":false,"tag_url":"search/?keyword=None","title":"习近平结束对西班牙、阿根廷、巴拿马、葡萄牙国事访问并出席二十国集团领导人第十三次峰会回到北京","single_mode":false,"middle_mode":false,"abstract":"新华社北京12月6日电12月6日，在结束对西班牙、阿根廷、巴拿马、葡萄牙国事访问并出席二十国集团领导人第十三次峰会后，国家主席习近平回到北京。","tag":"news_politics_general","label":["巴拿马","何立峰","王毅","彭丽媛","战斗机"],"behot_time":1544081116,"source_url":"/group/6631723256560747011/","source":"新华社","more_mode":false,"article_genre":"article","comments_count":2727,"is_stick":true,"group_source":2,"item_id":"6631723256560747011","has_gallery":false,"group_id":"6631723256560747011","media_url":"/c/user/5757425042/"},{"single_mode":true,"abstract":"其实这是一个有点温暖的故事微博用户@蔡鸿岩发微博说，他在滴滴上约到一辆出租车，副驾驶上坐着一位老人。","middle_mode":true,"more_mode":true,"tag":"news_society","label":["滴滴打车","移动互联网","社会"],"comments_count":14,"tag_url":"news_society","title":"\\"可以选择不坐，但请别差评！\\"","chinese_tag":"社会","source":"新华社","group_source":2,"has_gallery":false,"media_url":"/c/user/5757425042/","media_avatar_url":"//p2.pstatp.com/large/9519/925052030","image_list":[{"url":"//p3.pstatp.com/list/pgc-image/RBFOXSSG6j30jb"},{"url":"//p1.pstatp.com/list/pgc-image/RBGYLvqHMOBRLd"},{"url":"//p99.pstatp.com/list/pgc-image/RBFOXSmBdVGQSJ"}],"source_url":"/group/6631630391079862791/","article_genre":"article","item_id":"6631630391079862791","is_feed_ad":false,"behot_time":1544081104,"image_url":"//p3.pstatp.com/list/190x124/pgc-image/RBFOXSSG6j30jb","group_id":"6631630391079862791","middle_image":"http://p3.pstatp.com/list/pgc-image/RBFOXSSG6j30jb"},{"log_extra":"{\\"ad_price\\":\\"XAjO4v_rXkVcCM7i_-teRROvpcqvRd2Cooo4jg\\",\\"convert_component_suspend\\":0,\\"convert_id\\":0,\\"external_action\\":0,\\"req_id\\":\\"201812061525220100110540323038D7\\",\\"rit\\":1}","image_url":"//sf3-ttcdn-tos.pstatp.com/img/web.business.image/201811065d0de860e3b4aa0b4fc2a472~640x0.image","read_count":49880,"ban_comment":0,"single_mode":true,"abstract":"","image_list":[],"has_video":false,"article_type":1,"tag":"ad.platform.site","display_info":"怕被抄袭被侵权？版权登记，给你的作品一个身份证明！","has_m3u8_video":0,"label":"广告","user_verified":0,"aggr_type":1,"expire_seconds":313279995,"cell_type":0,"article_sub_type":0,"tag_url":"search/?keyword=None","bury_count":0,"title":"怕被抄袭被侵权？版权登记，给你的作品一个身份证明！","ignore_web_transform":1,"source_icon_style":3,"tip":0,"hot":0,"share_url":"http://m.toutiao.com/group/6620655139470442765/?iid=0&app=news_article","has_mp4_video":0,"source":"猪八戒网","comment_count":12,"article_url":"https://zt.ipr.zbj.com/copyright/bqdjj/?_union_identify=14&_union_uid=14658852&_union_itemid=1615053","filter_words":[{"id":"4:2","name":"看过了","is_selected":false},{"id":"2:0","name":"屏蔽:猪八戒网的广告","is_selected":false},{"id":"1:89","name":"屏蔽:代理类广告","is_selected":false},{"id":"1:24","name":"屏蔽:商务服务类广告","is_selected":false}],"has_gallery":false,"publish_time":1541491397,"ad_id":1616370883588126,"action_list":[{"action":1,"extra":{},"desc":""},{"action":3,"extra":{},"desc":""},{"action":7,"extra":{},"desc":""},{"action":9,"extra":{},"desc":""}],"has_image":false,"cell_layout_style":1,"tag_id":6620655139470442000,"source_url":"https://zt.ipr.zbj.com/copyright/bqdjj/?_union_identify=14&_union_uid=14658852&_union_itemid=1615053","video_style":0,"verified_content":"","is_feed_ad":true,"large_image_list":[],"item_id":"6620655139470442765","natant_level":2,"article_genre":"ad","level":0,"cell_flag":262154,"source_open_url":"sslocal://search?from=feed_source&keyword=%E7%8C%AA%E5%85%AB%E6%88%92%E7%BD%91","display_url":"https://zt.ipr.zbj.com/copyright/bqdjj/?_union_identify=14&_union_uid=14658852&_union_itemid=1615053","source_avatar":"http://sf1-ttcdn-tos.pstatp.com/obj/web.business.image/201805215d0d8ae52618029d42e5a2a8","digg_count":0,"behot_time":1544081098,"article_alt_url":"http://m.toutiao.com/group/article/6620655139470442765/","cursor":1544081098999,"url":"https://zt.ipr.zbj.com/copyright/bqdjj/?_union_identify=14&_union_uid=14658852&_union_itemid=1615053","preload_web":0,"ad_label":"广告","user_repin":0,"label_style":3,"item_version":0,"group_id":"6620655139470442765","middle_image":{"url":"http://sf3-ttcdn-tos.pstatp.com/img/web.business.image/201811065d0de860e3b4aa0b4fc2a472~640x0.image","width":456,"url_list":[{"url":"http://sf3-ttcdn-tos.pstatp.com/img/web.business.image/201811065d0de860e3b4aa0b4fc2a472~640x0.image"},{"url":"http://sf6-ttcdn-tos.pstatp.com/img/web.business.image/201811065d0de860e3b4aa0b4fc2a472~640x0.image"},{"url":"http://sf1-ttcdn-tos.pstatp.com/img/web.business.image/201811065d0de860e3b4aa0b4fc2a472~640x0.image"}],"uri":"large/web.business.image/201811065d0de860e3b4aa0b4fc2a472","height":256}},{"single_mode":true,"abstract":"即将接受手术的患者，当得知要麻醉，尤其是全身麻醉时，都会对麻醉可能带来的副作用而忧心忡忡，担心麻醉会影响记忆力，真的是这样吗。","middle_mode":true,"more_mode":true,"tag":"news_health","label":["药品","健康"],"comments_count":513,"tag_url":"news_health","title":"全麻只是“睡一觉”吗？为啥很多人说记忆力变差了？这你得知道","chinese_tag":"健康","source":"问上医","group_source":2,"has_gallery":false,"media_url":"/c/user/50789693843/","media_avatar_url":"//p1.pstatp.com/large/e5900080d2481885767","image_list":[{"url":"//p3.pstatp.com/list/pgc-image/1543979169747e4a7f4db4d"},{"url":"//p3.pstatp.com/list/dfic-imagehandler/98963d50-89e3-4a1d-bf0f-8c9d54110b8f"},{"url":"//p3.pstatp.com/list/dfic-imagehandler/d3bd43c7-3b05-4b9c-b7e8-ce87b076ca71"}],"source_url":"/group/6631345423044837891/","article_genre":"article","item_id":"6631345423044837891","is_feed_ad":false,"behot_time":1544081092,"image_url":"//p3.pstatp.com/list/190x124/pgc-image/1543979169747e4a7f4db4d","group_id":"6631345423044837891","middle_image":"http://p3.pstatp.com/list/pgc-image/1543979169747e4a7f4db4d"},{"single_mode":true,"abstract":"文/薇薇安拾柒从浅编辑/九月五月份，在这个南方小城最适合出行的时候，李铭从ofo离职了。最后一天，办公室空空荡荡，他安静地收拾东西离开。","middle_mode":true,"more_mode":false,"tag":"qingyunjihua","comments_count":2817,"tag_url":"search/?keyword=None","title":"前员工深度揭露ofo败局：挥霍、贪污、站队、大裁员","label":["空军","阿里巴巴","自行车","科技"],"source":"锌财经","group_source":2,"has_gallery":false,"media_url":"/c/user/59722363136/","media_avatar_url":"//p9.pstatp.com/large/39b90002ed81f50bba6f","source_url":"/group/6631134579581272580/","article_genre":"article","item_id":"6631134579581272580","is_feed_ad":false,"behot_time":1544081086,"image_url":"//p3.pstatp.com/list/190x124/pgc-image/fbbfe1e7a68b4e7899f07035064e98de","group_id":"6631134579581272580","middle_image":"http://p3.pstatp.com/list/pgc-image/fbbfe1e7a68b4e7899f07035064e98de"},{"single_mode":true,"abstract":"天气越来越冷，买点羊肉回家涮火锅成了很多人的选择。不过最近几个月，许多消费者发现，羊肉价格出现了不同程度的上涨，是什么原因导致这轮羊肉价格上涨的呢。","middle_mode":true,"more_mode":true,"tag":"news_agriculture","label":["合作社","畜牧业","农产品","种植业","农业"],"comments_count":871,"tag_url":"search/?keyword=%E4%B8%89%E5%86%9C","title":"三大原因揭秘：羊肉价格为何持续上涨？","chinese_tag":"三农","source":"央视财经","group_source":2,"has_gallery":false,"media_url":"/c/user/3259097877/","media_avatar_url":"//p1.pstatp.com/large/97d000c210ea2ab96df","image_list":[{"url":"//p1.pstatp.com/list/pgc-image/RAtbDXjkCJgkV"},{"url":"//p99.pstatp.com/list/pgc-image/RAtbDY56zH10tG"},{"url":"//p3.pstatp.com/list/pgc-image/RAtbDYGAcnnXTR"}],"source_url":"/group/6629665413611389453/","article_genre":"article","item_id":"6629665413611389453","is_feed_ad":false,"behot_time":1544081080,"image_url":"//p1.pstatp.com/list/190x124/pgc-image/RAtbDXjkCJgkV","group_id":"6629665413611389453","middle_image":"http://p1.pstatp.com/list/pgc-image/RAtbDXjkCJgkV"},{"single_mode":true,"abstract":"”银河系中大概有2500亿颗类似太阳的恒星，而围绕恒星的行星更是不计其数。即便一颗行星，能发展出文明的概率低到几乎为零。","middle_mode":true,"more_mode":true,"tag":"science_all","label":["外星生命","恩里科·费米","动物","地球","宇宙"],"comments_count":120,"tag_url":"search/?keyword=%E7%A7%91%E5%AD%A6","title":"最后的“野生人类动物园”，在这里连杀人都是无罪的","chinese_tag":"科学","source":"SME科技故事","group_source":2,"has_gallery":false,"media_url":"/c/user/5530910654/","media_avatar_url":"//p1.pstatp.com/large/ef600163b80d8e3d5b2","image_list":[{"url":"//p99.pstatp.com/list/pgc-image/2233731a586a4414a01b2898cdfbc096"},{"url":"//p3.pstatp.com/list/pgc-image/148f035f83d34fc788f3b32b7ce836df"},{"url":"//p99.pstatp.com/list/pgc-image/9cf1035c1b2f4b10bad359b6be0484bb"}],"source_url":"/group/6631121919984796167/","article_genre":"article","item_id":"6631121919984796167","is_feed_ad":false,"behot_time":1544081074,"image_url":"//p99.pstatp.com/list/190x124/pgc-image/2233731a586a4414a01b2898cdfbc096","group_id":"6631121919984796167","middle_image":"http://p99.pstatp.com/list/pgc-image/2233731a586a4414a01b2898cdfbc096"},{"single_mode":true,"abstract":"很多人都有一个疑问：中国第三大岛崇明岛，距离江苏南通更近，为什么却属于上海。崇明岛在唐朝之前并不存在，唐初也只有两个相隔三十多公里的小沙洲：东沙、西沙。","middle_mode":true,"more_mode":true,"tag":"news_society","label":["崇明岛","长兴岛","长江","唐中宗","横沙岛"],"comments_count":465,"tag_url":"news_society","title":"崇明岛从江苏划给上海，为何在岛上给南通留了两块飞地？","chinese_tag":"社会","source":"独行客地图帝","group_source":2,"has_gallery":false,"media_url":"/c/user/4353779681/","media_avatar_url":"//p2.pstatp.com/large/3605/220264998","image_list":[{"url":"//p3.pstatp.com/list/pgc-image/cecd3ab67c3c48c0af5c6e2ebc8ebc52"},{"url":"//p3.pstatp.com/list/pgc-image/740b0462bc784c008df1ddad489cef15"},{"url":"//p99.pstatp.com/list/pgc-image/23846b6e26a743bd98b785f329ca1053"}],"source_url":"/group/6629551607648354820/","article_genre":"article","item_id":"6629551607648354820","is_feed_ad":false,"behot_time":1544081068,"image_url":"//p3.pstatp.com/list/190x124/pgc-image/cecd3ab67c3c48c0af5c6e2ebc8ebc52","group_id":"6629551607648354820","middle_image":"http://p3.pstatp.com/list/pgc-image/cecd3ab67c3c48c0af5c6e2ebc8ebc52"}],"next":{"max_behot_time":1544081068}}';

main() {

  print('测试命令行转换的普通实体类 ->');
  testEntityConvertedByCli();
  print('\n测试文件批量转换的普通实体类 ->');
  testEntityConvertedFromFile();
  print('\n测试支持json_serializable的实体类 ->');
  testEntityConvertedSupportJsonSerializable();

  print('\n\nWELL DONE! ALL OUTPUT ENTITY TEST SUCCESSFUL!!\n\n');
}

void testEntityConvertedByCli() {
  
  var j1 = Json1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);
  print(jsonEncode(j1.toJson()));
  
  var j2 = Json2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');
  print(jsonEncode(j2.toJson()));
  
  var j3 = Json3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');
  print(jsonEncode(j3.toJson()));
  
  var j4 = Json4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);
  print(jsonEncode(j4.toJson()));
  
  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas":[...]}
  var list = jsonDecode(json5);
  var j5 = Json5.fromJson({'datas':list});
  assertTrue(j5.datas.length == 1);
  print(jsonEncode(j5.toJson()));
  
  var j6 = Json6.fromJson(jsonDecode(json6));
  assertTrue(j6.data.length == 8, err: 'data.length is ${j6.data.length}');
  assertTrue(j6.data[0].image_list.length == 3);
  print(jsonEncode(j6.toJson()));
}

void testEntityConvertedSupportJsonSerializable() {
  
  var j1 = JsonS1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);
  print(jsonEncode(j1.toJson()));
  
  var j2 = JsonS2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');
  print(jsonEncode(j2.toJson()));
  
  var j3 = JsonS3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');
  print(jsonEncode(j3.toJson()));
  
  var j4 = JsonS4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);
  print(jsonEncode(j4.toJson()));
  
  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas":[...]}
  var list = jsonDecode(json5);
  var j5 = JsonS5.fromJson({'datas':list});
  assertTrue(j5.datas.length == 1);
  print(jsonEncode(j5.toJson()));
  
  var j6 = JsonS6.fromJson(jsonDecode(json6));
  assertTrue(j6.data.length == 8, err: 'data.length is ${j6.data.length}');
  assertTrue(j6.data[0].image_list.length == 3);
  print(jsonEncode(j6.toJson()));
}


void testEntityConvertedFromFile() {
  
  var j1 = JsonF1.fromJson(jsonDecode(json1));
  assertTrue(j1.msg == 'ok');
  assertTrue(j1.result == 1);
  print(jsonEncode(j1.toJson()));
  
  var j2 = JsonF2.fromJson(jsonDecode(json2));
  assertTrue(j2.data.answer == 'A');
  print(jsonEncode(j2.toJson()));
  
  var j3 = JsonF3.fromJson(jsonDecode(json3));
  assertTrue(j3.streets is List);
  assertTrue(j3.streets.length == 2);
  assertTrue(j3.streets[0] == 'address1');
  print(jsonEncode(j3.toJson()));
  
  var j4 = JsonF4.fromJson(jsonDecode(json4));
  assertTrue(j4.images[0].id == 11);
  print(jsonEncode(j4.toJson()));
  
  // map list 比较特殊，转换时，list：[...]会被转换成map：{"datas":[...]}
  var list = jsonDecode(json5);
  var j5 = JsonF5.fromJson({'datas':list});
  assertTrue(j5.datas.length == 1);
  print(jsonEncode(j5.toJson()));
  
  var j6 = JsonF6.fromJson(jsonDecode(json6));
  assertTrue(j6.data.length == 8, err: 'data.length is ${j6.data.length}');
  assertTrue(j6.data[0].image_list.length == 3);
  print(jsonEncode(j6.toJson()));
}


void assertTrue(bool b, {String err}) {
  if (!b) {
    throw Exception(err ?? 'assert err!!!');
  }
}