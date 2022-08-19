import 'package:js/js.dart';

@JS('jwplayer')
class PlayerAPI {
  external PlayerAPI(dynamic id);
  external void setup(dynamic config);
}
