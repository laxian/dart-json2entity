

# j2e 是json2entity 的简写，等价

# 查看帮助，-h可省略
j2e -h

# 1. 输出到标准输出
j2e -j '{"code":1}'

# 2. 输出到文件 ./lib/demo_model.dart
j2e -j '{"code":1}' -o lib/DemoModel

# 3. 我使用了`json_serializable`，使用`-s`
j2e -j '{"code":1}' -s

# 4. 从文件读取单个json，注意处理字符串转义
j2e -j "`cat example/juejin.json`"

# 5. 我想批量处理，从文件读取输入，文件格式参考：example/input.json
j2e -f example/input.json -o ./example/output/

# zip_json是一个工具，可以简化输入的json字符串，
# 如：   [{"k1":1, "k2":0},  {"k2": 0, "k3": true}] 
# 简化为：[{"k1":1, "k2":0, "k3":true}]
zip_json '[{"k1":1, "k2":0},  {"k2": 0, "k3": true}]'