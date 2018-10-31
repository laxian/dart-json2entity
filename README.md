# 给Dart和flutter的GsonFormat

本周入坑flutter，发现竟然Dart语言竟没有json转实体类的工具，就手动写了个简陋的。能用，慢慢改善。

## 功能

-   输入json 字符串，Model名和json定义在input.json，输出实体类。类似Java的GsonFormat
-   支持json_serializable
    执行成功后，执行:
    `flutter packages pub run build_runner build --delete-conflicting-outputs`

## 用法：

dart json2bean.dart

## 后期

-   将支持命令行参数
