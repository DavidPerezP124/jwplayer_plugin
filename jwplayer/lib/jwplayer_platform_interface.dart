import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile/jwplayer_method_channel.dart';

class JWPlatformException extends Error {
  final String? message;
  JWPlatformException(String this.message);
}

abstract class JWPlayerPlatform extends PlatformInterface {
  /// Constructs a FlutterPocPlatform.
  JWPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static JWPlayerPlatform _instance = MethodChannelJWPlayer();

  /// The default instance of [FlutterPocPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPoc].
  static JWPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPocPlatform] when
  /// they register themselves.
  static set instance(JWPlayerPlatform instance) {
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

  Future<int> create() {
    throw UnimplementedError('create() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> setLicenseKey(String licenseKey) {
    throw UnimplementedError('setLicenseKey() has not been implemented.');
  }

  Future<void> play(int id) {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<void> pause(int id) {
    throw UnimplementedError('pause() has not been implemented.');
  }

  Future<void> stop(int id) {
    throw UnimplementedError('stop() has not been implemented.');
  }

  Future<void> seek(double to, int id) {
    throw UnimplementedError('see() has not been implemented.');
  }

  Future<void> setConfig(Map<String, dynamic> config, int id) {
    throw UnimplementedError('setConfig() has not been implemented.');
  }

  Widget buildView(int viewId, void Function(int) onPlatformViewCreated) {
    throw UnimplementedError('buildView() has not been implemented.');
  }

  Future<void> dispose(int viewId) {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  /// Returns a Stream of [VideoEventType]s.
  Stream<VideoEvent> videoEventsFor(int textureId) {
    throw UnimplementedError('videoEventsFor() has not been implemented.');
  }
}

@immutable
class VideoEvent {
  /// Creates an instance of [VideoEvent].
  ///
  /// The [eventType] argument is required.
  ///
  /// Depending on the [eventType], the [duration], [size].
  // in all of the other video player packages, fix this, and then update
  // the other packages to use const.
  // ignore: prefer_const_constructors_in_immutables
  VideoEvent(
      {required this.eventType,
      this.duration,
      this.position = Duration.zero,
      this.size,
      this.bufferPercent = 0,
      this.bufferPosition = 0,
      this.state = PlayerState.idle});

  /// The type of the event.
  final VideoEventType eventType;

  /// Duration of the video.
  ///
  /// Only used if [eventType] is [VideoEventType.initialized].
  final Duration? duration;

  /// Size of the video.
  ///
  /// Only used if [eventType] is [VideoEventType.initialized].
  final Size? size;

  /// Player state
  final PlayerState state;

  final Duration position;

  final double? bufferPercent;

  final double? bufferPosition;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoEvent &&
            runtimeType == other.runtimeType &&
            eventType == other.eventType &&
            duration == other.duration &&
            size == other.size &&
            position == other.position &&
            bufferPercent == other.bufferPercent;
  }

  @override
  int get hashCode => Object.hash(eventType, duration, size, position);
}

/// Type of the event.
///
/// Emitted by the platform implementation when the video is initialized or
/// completed.
enum VideoEventType {
  /// The player state has changed
  state,

  /// The player has buffered more content
  buffer,

  /// The player has a time position update
  time,

  /// The player has been initialized.
  initialized,

  /// The playback has ended.
  completed,

  /// An unknown event has been received.
  unknown,
}

enum PlayerState {
  /// The player is currently playing
  playing,

  /// The players is paused
  paused,

  /// The player has completed its content
  complete,

  /// The player is currently stalled and need to buffer content to continue playback
  buffering,

  /// The player has not begun playback
  idle
}
