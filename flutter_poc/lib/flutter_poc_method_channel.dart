import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_poc_platform_interface.dart';

/// An implementation of [FlutterPocPlatform] that uses method channels.
class MethodChannelFlutterPoc extends FlutterPocPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_poc');

  @override
  Future<String> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> play() async {
    final playerView = await methodChannel.invokeMethod<String>('play');
    return playerView;
  }
}
