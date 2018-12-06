#!/bin/sh

set -e

# // 5种不同类型json测试用例，分别是
# // 简单无嵌套json
# // 嵌套json
# // 嵌套简单列表json
# // 嵌套对象列表json
# // 对象列表json
json1='{"result":1,"msg":"ok"}';
json2='{"result":1,"msg":"ok","data":{"answer":"A"}}';
json3='{"city":"Mumbai","streets":["address1","address2"]}';
json4='{"id":1,"name":"ProductName","images":[{"id":11,"imageName":"xCh-rhy"},{"id":31,"imageName":"fjs-eun"}]}';
json5='[{"albumId":1,"id":1,"title":"accusamus","url":"http://placehold.it/600/92c952","thumbnailUrl":"http://placehold.it/150/92c952"}]';

# 和上面5中用例一样
inputFile=./input/input.json

# normal
./json2entity -j $json1 --output ./output/Json1
./json2entity -j $json2 --output ./output/Json2
./json2entity -j $json3 --output ./output/Json3
./json2entity -j $json4 --output ./output/Json4
./json2entity -j $json5 --output ./output/Json5

# json_serializable support
./json2entity -j $json1 --output ./output/JsonS1 -s
./json2entity -j $json2 --output ./output/JsonS2 -s
./json2entity -j $json3 --output ./output/JsonS3 -s
./json2entity -j $json4 --output ./output/JsonS4 -s
./json2entity -j $json5 --output ./output/JsonS5 -s

# input from file
./json2entity -f $inputFile --output ./output/
# ./json2entity -f $inputFile --output ./output/ -s
