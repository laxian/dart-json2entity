# Convert json to entity class like GsonFormat for Java

[中文](https://github.com/laxian/flutter-gsonformat/blob/master/README.md)

As a freshman for Flutter, I need a json-to-entity converter for Dart, So I write this poor tool。
It's simple BUT HELPFUL.

## Feature

-   Input json, output entity class file in Dart language.
-   support json_serializable
    U need do this by yourself:`flutter packages pub run build_runner build --delete-conflicting-outputs`

## How to use

* `dart json2bean.dart`
* `dart cli.dart -j '{"age":18, "name": "zhouweixian"}' -o
Age`

## Coming later

-   Command line parameter support
-   Customize
