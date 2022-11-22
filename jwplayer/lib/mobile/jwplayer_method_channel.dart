import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../jwplayer_platform_interface.dart';

/// An implementation of [JWPlayerPlatform] that uses method channels.
class MethodChannelJWPlayer extends JWPlayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final platformChannel = const MethodChannel('jwplayer');

  @visibleForTesting
  final viewChannel = const MethodChannel('playerview');

  @override
  Future<void> init() async {
    platformChannel.invokeMethod<String>('init');
  }

  @override
  Future<int> create() async {
    final id = await viewChannel.invokeMethod<int>('create');
    return id!;
  }

  @override
  Widget buildView(int viewId, void Function(int) onPlatformViewCreated) {
    const String viewType = '<platform-view-type>';

    final platform = defaultTargetPlatform;
    switch (platform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams: <String, dynamic>{
            'id': viewId,
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams: <String, dynamic>{
            'id': viewId,
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError(
            'Platform $platform is not supported by this plugin');
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await platformChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> setLicenseKey(String licenseKey) async {
    platformChannel
        .invokeMethod<String>('setLicenseKey', {"licenseKey": licenseKey});
  }

  @override
  Future<void> setConfig(Map<String, dynamic> config, int id) async {
    viewChannel.invokeMethod<String>('setConfig', {"config": config, "id": id});
  }

  @override
  Future<void> play(int id) async {
    viewChannel.invokeMethod<String>('play', {"id": id});
  }

  @override
  Future<void> pause(int id) async {
    viewChannel.invokeMethod<String>('pause', {"id": id});
  }

  @override
  Future<void> stop(int id) async {
    viewChannel.invokeMethod<String>('stop', {"id": id});
  }

  @override
  Future<void> seek(double to, int id) async {
    viewChannel.invokeMethod<String>('seek', {"to": to, "id": id});
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return _eventChannelFor(textureId)
        .receiveBroadcastStream()
        .map((dynamic event) {
      final Map<dynamic, dynamic> map = event as Map<dynamic, dynamic>;
      switch (map['event']) {
        case 'isReady':
          return VideoEvent(
            eventType: VideoEventType.initialized,
          );
        case 'time':
          final Map<dynamic, dynamic> values =
              event['values'] as Map<dynamic, dynamic>;
          // Convert position to milliseconds for more exact updates.
          int position = ((values['position'] as double) * 1000).ceil();
          int duration = ((values['duration'] as double)).round();
          return VideoEvent(
            eventType: VideoEventType.time,
            position: Duration(milliseconds: position),
            duration: Duration(seconds: duration),
          );
        case 'buffer':
          final Map<dynamic, dynamic> values =
              event['values'] as Map<dynamic, dynamic>;
          // Convert position to milliseconds for more exact updates.
          double percent = (values['percent'] as double);
          double position = (values['position'] as double);
          if (percent.isNaN || percent.isInfinite) {
            return VideoEvent(eventType: VideoEventType.unknown);
          }
          return VideoEvent(
              eventType: VideoEventType.buffer,
              bufferPercent: percent,
              bufferPosition: position);
        case 'play':
          return VideoEvent(
              eventType: VideoEventType.state, state: PlayerState.playing);
        case 'pause':
          return VideoEvent(
              eventType: VideoEventType.state, state: PlayerState.paused);
        default:
          return VideoEvent(eventType: VideoEventType.unknown);
      }
    });
  }

  EventChannel _eventChannelFor(int textureId) {
    return const EventChannel('com.jwplayer.view');
  }
}
