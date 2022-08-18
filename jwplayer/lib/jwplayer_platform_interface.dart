import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'jwplayer_method_channel.dart';

abstract class JwplayerPlatform extends PlatformInterface {
  /// Constructs a FlutterPocPlatform.
  JwplayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static JwplayerPlatform _instance = MethodChannelJwplayer();

  /// The default instance of [FlutterPocPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPoc].
  static JwplayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPocPlatform] when
  /// they register themselves.
  static set instance(JwplayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the platform interface and disposes all existing players.
  ///
  /// This method is called when the plugin is first initialized
  /// and on every full restart.
  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<int?> create() {
    throw UnimplementedError('create() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> play() {
    throw UnimplementedError('play() has not been implemented.');
  }

  Widget buildView(int viewId) {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
