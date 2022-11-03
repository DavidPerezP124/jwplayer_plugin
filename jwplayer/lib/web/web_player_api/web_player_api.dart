import 'package:js/js.dart';

@JS('jwplayer')
class PlayerAPI {
  external PlayerAPI(dynamic id);
  external void setup(dynamic config);
  external void play();
  external void pause();
  external void stop();
}

@JS('jwplayer.version')
external String playerVersion;
