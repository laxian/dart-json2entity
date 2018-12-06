main(List<String> args) {
  var abc;
  assertTrue(abc != null, err: 'ABC IS NULL');
    print('ok');
  }
  
  void assertTrue(bool b, {String err}) {
    if (!b) {
      throw Exception(err??'assert err!!!');
    }
}