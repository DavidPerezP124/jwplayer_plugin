import 'flutter_poc_platform_interface.dart';

class FlutterPoc {
  Future<String?> getPlatformVersion() {
    return FlutterPocPlatform.instance.getPlatformVersion();
  }

  Future<String?> play() {
    return FlutterPocPlatform.instance.play();
  }
}
