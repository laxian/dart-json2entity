#!/bin/sh

set -e


dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeDartModel 
dart ./cli.dart -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeDartModel2 -v --support-json-serializable 

dart ./cli.dart -f input/input.json -o output/ -v
dart ./cli.dart -f input/input.json -o output/entity/ -v --support-json-serializable 


./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeModel 
./json2entity -j '{"result":1,"msg":"success","data":{"age":18}}' --output ./output/AgeModel2 -v --support-json-serializable 

./json2entity -f input/input.json -o output/ -v
./json2entity -f input/input.json -o output/entity/ -v --support-json-serializable 
