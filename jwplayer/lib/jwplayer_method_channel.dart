import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'jwplayer_platform_interface.dart';

/// An implementation of [JwplayerPlatform] that uses method channels.
class MethodChannelJwplayer extends JwplayerPlatform {
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
  Future<int?> create() async {
    final id = await viewChannel.invokeMethod<int>('create');
    return id;
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
  Future<void> play() async {
    viewChannel.invokeMethod<String>('play');
  }
}
