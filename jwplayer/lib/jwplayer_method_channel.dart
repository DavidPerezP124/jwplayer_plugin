import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'jwplayer_platform_interface.dart';

/// An implementation of [JwplayerPlatform] that uses method channels.
class MethodChannelJwplayer extends JwplayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jwplayer');

  @override
  Future<void> init() async {
    methodChannel.invokeMethod<String>('init');
  }

  @override
  Future<int?> create() async {
    final id = await methodChannel.invokeMethod<int>('create');
    return id;
  }

  @override
  Widget buildView(int viewId) {
    const String viewType = '<platform-view-type>';

    final platform = defaultTargetPlatform;
    switch (platform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          onPlatformViewCreated: (_) {},
          creationParams: <String, dynamic>{
            'id': viewId,
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          onPlatformViewCreated: (_) {},
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
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
