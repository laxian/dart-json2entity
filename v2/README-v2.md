# json转实体类文件工具 -- 另一种实现思路

之前的是为了项目中快速使用，才做了json2entity。我称之为v1。功能基本完成，命令行参数也都调试通过。

但是，需求总是不断的变化，v1代码没有层次，改起来比较费劲，所以我决定换一种思路是实现，才有了v2.

## [v1](https://github.com/laxian/flutter-gsonformat/blob/master/v1/README.md)

## Clazz
class 能完成原始的json string -> entity source file

    基本的转换功能在`Clazz`中实现。
    转换分解成以下步骤：

    1. decorator        注解、装饰器
    2. class declare    类声明，class xxx {
    3. fields           类成员变量
    4. constructor      构造函数
    5. fromJson method  fromJson方法
    6. toJson method    toJson方法
    7. 拼接1-6步，合成class
    8. 递归1-7，合成children
    9. 输出


## JsonSerializableClazz
 增加json_serializable的支持

和一般entity的差异：
1. json_serializable 格式的实体类，多了一个注解`@JsonSerializable()`
2. fromJson和toJson方法也有变化
3. 生成后，还需要通过命令生成另一部分
`flutter packages pub run build_runner build`
