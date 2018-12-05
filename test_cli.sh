#!/bin/sh

set -e

# test dart
# dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeDartModel 
# dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeDartModel2 -v --support-json-serializable 

# dart ./cli.dart -f input/input.json -o output/ -v
# dart ./cli.dart -f input/input.json -o output/entity/ -v --support-json-serializable 

# // test shell
# ./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeModel 
# ./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeModel2 -v --support-json-serializable 

# ./json2entity -f input/input.json -o output/ -v
# ./json2entity -f input/input.json -o output/entity/ -v --support-json-serializable 


# test v2
dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeDartModel --v2
dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeDartModel2 -v --support-json-serializable --v2

dart ./cli.dart -f input/input.json -o output/ -v --v2
dart ./cli.dart -f input/input.json -o output/entity/ -v --support-json-serializable --v2


./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeModel --v2
./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeModel2 -v --support-json-serializable --v2

./json2entity -f input/input.json -o output/ -v --v2
./json2entity -f input/input.json -o output/entity/ -v --support-json-serializable --v2
