import 'package:js/js_util.dart' as js;

extension Objectify on Map {
  static Object mapToJSObj(Map<dynamic, dynamic> a) {
    var object = js.newObject();
    a.forEach((k, v) {
      var key = k;
      var value = v;
      js.setProperty(object, key, value);
    });
    return object;
  }
}
