# 用Dart语言实现的json转Dart实体类工具

## v1 ****DEPRECATED****
最初版本，功能比较全。但是代码比较难修改。

[README-v1](https://github.com/laxian/flutter-gsonformat/blob/master/v1/README.md)

## v2
新版本

[README-v2](https://github.com/laxian/flutter-gsonformat/blob/master/v2/README-v2.md)

## CLI
两个版本公用一套cli，通过--v1参数控制是否使用v1。默认使用v2

## 快速尝试
`./json2entity -j '{"result":1,"msg":"ok","data":{"age":18}}' -o output/myage`

## 命令行语法
```shell
  Sample:
    dart cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' -o ./output/Age -v --json-serializable-support

  SYNOPSIS
    dart cli.dart -j <json_string> -o <output_path> [-v] [-s]
    -o, --output
          output path
    -j, --json: 
          input json string
    -f, --file: 
          input json list from file. See \$PROJECT_ROOT/input/input.json
    -v, --verbose: 
          print verbose info
    -s, --json-serializable-support
          support json_serializable or not. default disable
    -V, --v1
          use new version convertor
```

## More Sample
[test_cli.sh](https://github.com/laxian/flutter-gsonformat/blob/master/test_cli.sh)