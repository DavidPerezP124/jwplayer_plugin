import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetLicense {
  static final TargetPlatform _platform = defaultTargetPlatform;

  static String getLicense() {
    switch (_platform) {
      case TargetPlatform.android:
        return dotenv.get("ANDROID_LICENSE");
      case TargetPlatform.iOS:
        return dotenv.get("IOS_LICENSE");
      default:
        return "";
    }
  }
}
