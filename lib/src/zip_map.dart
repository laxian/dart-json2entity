/// 一个工具类，压缩一个json对应的map
/// 例如：json array里有两个json object，但这两个json object o1，和o2，
/// json [{'name':'leo','age':null,'gender':'male'},{'name':'joe','age':16,'job':'engineer'}]
/// o1={'name':'leo','country':'CN'}
/// o2={'name':'joe','age':16}
/// 可见o1没有age字段，o2没有country字段，在Api中，常见这种情况，一些非空字段可有可无的分散在
/// json array的不同对象中，对于一个json转实体类工具，如上例，
/// 需要一个尽可能完整的object o3={'name':'leo','age':18,'country':'CN'}
/// 才能生成完整的实体类
/// 输入类型[E]保持不变，zip，最终只是把所有层级的list的长度从n>1变为1，(若长度为0，则不变)
E zip<E>(E input) {
  if (input is List) {
    return zipList(input) as E;
  } else if (input is Map) {
    return zipMap(input) as E;
  }
  return input;
}

/// 输入必须为map，输出map。内部可能有list
Map zipMap(Map m) {
  for (var i = 0; i < m.entries.length; i++) {
    var item = m.entries.elementAt(i);
    if (item.value is Map) {
      // map递归
      m[item.key] = zipMap(item.value);
    } else if (item.value is List) {
      // 只有list才真正需要压缩
      m[item.key] = zipList(item.value);
    } else {
      // noop
    }
  }
  return m;
}

/// 输入一个list，输出list的长度不大于1，若有子元素，则必须包含原list子元素中所有字段
List zipList(List a) {
  if (a == null || a.isEmpty) {
    return [];
  }
  if (a.first is Map) {
    List<Map> a2 = a.map<Map>((i) => i).toList();
    // [Map, Map] zipSelf-> Map
    return [zipMap(a2.reduce(zip2))];
  } else if (a.first is List) {
    // [...],[...] reduce-> [......] zipN-> [.]
    return [zipList((a as List<List>).reduce((l, s) => l..addAll(s)))];
  } else /*raw type*/ {
    // 原始类型合并，取任意非空
    return [a.firstWhere((a) => a != null)];
  }
}

/// 合并两个map，合成的元素，包含[a]和[b]中所有的key
/// 若相同的key对应的value同样是Map，该key对应的map value，递归当前函数
///
Map zip2(Map a, Map b) {
  var es = a.entries.toList()..addAll(b.entries.toList());
  var keys = es.map((e) => e.key).toSet();
  var out = Map<String, dynamic>();
  keys.forEach((k) {
    var list = es.where((e) => e.key == k).map((e) => e.value).toList();
    if (list == null || list.isEmpty) {
      out[k] = null;
    } else if (list.length == 1) {
      out[k] = list.first;
    } else if (list.first is List) {
      // only two: first last
      var listToZip = List();
      listToZip..addAll(list.first)..addAll(list.last);
      out[k] = zipList(listToZip);
    } else if (list.first is Map) {
      List<Map> l = list.map<Map>((i) => i).toList();
      out[k] = l.reduce(zip2);
    } else {
      out[k] = list.reduce((a, b) => a != null ? a : b);
    }
  });
  return out;
}
