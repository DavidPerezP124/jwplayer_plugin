import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwplayer/jwplayer.dart';
import 'package:jwplayer/jwplayer_platform_interface.dart';
import 'package:jwplayer/jwplayer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJwplayerPlatform
    with MockPlatformInterfaceMixin
    implements JwplayerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<String?> play() {
    // TODO: implement play
    throw UnimplementedError();
  }

  @override
  Future<void> setLicenseKey(String licenseKey) {
    // TODO: implement setLicenseKey
    throw UnimplementedError();
  }

  @override
  Widget buildView(int viewId, void Function(int p1) onPlatformViewCreated) {
    // TODO: implement buildView
    throw UnimplementedError();
  }

  @override
  Future<void> setConfig(Map<String, dynamic> config, int id) {
    // TODO: implement setConfig
    throw UnimplementedError();
  }
}

void main() {
  final JwplayerPlatform initialPlatform = JwplayerPlatform.instance;

  test('$MethodChannelJwplayer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJwplayer>());
  });

  test('getPlatformVersion', () async {
    MockJwplayerPlatform fakePlatform = MockJwplayerPlatform();
    JwplayerPlatform.instance = fakePlatform;

    expect(await JWVideoPlayer.getPlatformVersion(), '42');
  });
}
