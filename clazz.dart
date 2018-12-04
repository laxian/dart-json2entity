class Clazz {

  Clazz(this._name, this.fields, this.decorators, [this.parent]);

  List <String> decorators;
  String _name;
  String get parentName => parent?.name;
  Clazz parent;

  get name => _name;

  // type: value. eg. int age.
  Map <String, String> fields;

  @override
  String toString() {
    // 类组成元素
    List<String> classFrags = <String>[];
    String decor = '';
    // 1. decorators
    if (hasValue(decorators)) {
      decor = decorators.join('\n');
      classFrags.add(decor);
    }
    // 2. class declare
    String classDeclare = buildClassDeclare();
    classFrags.add(classDeclare);
    // 3. fields declare
    if(hasValue(fields)) {
      var fieldPairs = fields.entries.toList().map((kv){return '${kv.key} ${kv.value}';}).join(';\n');
      classFrags.add('$fieldPairs');
    }
    // 4. constructor
    String constructor = buildConstructor();
    classFrags.add(constructor);
    // 5. fromJson
    String fromJson = buildFromJson();
    classFrags.add(fromJson);
    // 6. toJson
    String toJson = buildToJson();
    classFrags.add(toJson);
    classFrags.add('}');
    return classFrags.where((str)=>hasValue(str)).join('\n');
  }

  String buildClassDeclare() {
    if (hasValue(parentName)) {
      return 'class $_name extends $parentName {';
    }
    // default declare
    return 'class $_name {';
  }

  String buildConstructor() {
    if (hasValue(fields)) {
      String pre = '$_name({';
      var pairs = fields.entries.toList().map((kv) {
        return 'this.${kv.value}';
      }).join(',');
      String suffix = '})';
      var superConstructor = buildSuperConstructor();
      if (parent != null) {
        return '$pre\n$pairs\n$suffix:$superConstructor;\n';
      }
      return '$pre\n$pairs\n$suffix;\n';
    }
    return null;
  }

  String buildFromJson() {
    var pre = '$_name.fromJson(Map < String, dynamic > json)';
    var pairs = '';
    if (hasValue(fields)) {
      pairs = fields.entries.toList().map((kv){return '${kv.value}=json[\'${kv.value}\']';}).join(',');
      return '$pre:\n$pairs;';
    }
    return '$pre;';
  }

  String buildToJson() {
    var pre = 'Map <String, dynamic> toJson() => {';
    var post = '};';
    var pairs = '';
    if (hasValue(fields)) {
      pairs = fields.entries.toList().map((kv){return '\'${kv.value}\':${kv.value}';}).join(',');
      return '$pre\n$pairs\n$post';
    }
    return '$pre$post';
  }

  String buildSuperConstructor() {
    var frags = [];
    var pre = 'super(';
    frags.add(pre);
    if (hasValue(fields)) {
      var pairs = fields.entries.map((kv)=>kv.value).join(',');
      frags.join(pairs);
    }
    var post = ')';
    frags.add(post);
    return frags.join();
  }
}

hasValue(dynamic value) {
  return value ?.isNotEmpty ?? false;
}

main(List < String > args) {

  // test_hasValue();

  // test ClassMaker
  var base = Clazz('Base',{'int':'result', 'String': 'msg'} ,['@JsonSerializable()']);
  print(base.toString());
  var cm = Clazz('MyModel',{'int':'age', 'String': 'laxian'} ,['@JsonSerializable()'], base);
  print(cm.toString());

}

void test_hasValue() {
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