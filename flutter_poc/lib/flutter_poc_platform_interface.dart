import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_poc_method_channel.dart';

abstract class FlutterPocPlatform extends PlatformInterface {
  /// Constructs a FlutterPocPlatform.
  FlutterPocPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPocPlatform _instance = MethodChannelFlutterPoc();

  /// The default instance of [FlutterPocPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPoc].
  static FlutterPocPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPocPlatform] when
  /// they register themselves.
  static set instance(FlutterPocPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> play() {
    throw UnimplementedError('play() has not been implemented.');
  }
}
