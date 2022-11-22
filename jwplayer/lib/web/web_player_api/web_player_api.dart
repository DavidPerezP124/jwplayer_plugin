import 'package:js/js.dart' as js;

@js.JS('jwplayer')
class PlayerAPI {
  external PlayerAPI(dynamic id);
  external void setup(dynamic config);
  external void play();
  external void pause();
  external void stop();
  external void seek(dynamic position);
  external void on(String event, callback);
  external Object once(dynamic event, Object listener);
}

@js.JS('jwplayer.version')
external String playerVersion;
