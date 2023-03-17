import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jw_video_player/jwplayer.dart';
import 'package:jw_video_player/mobile/jwplayer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'helper/file_tool.dart';

class MockJwplayerPlatform
    with MockPlatformInterfaceMixin
    implements JWPlayerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    return Future.value();
  }

  @override
  Future<String?> play(int id) {
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

  @override
  Future<void> dispose(int viewId) {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<void> pause(int id) {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<void> seek(double to, int id) {
    // TODO: implement seek
    throw UnimplementedError();
  }

  @override
  Future<void> stop(int id) {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    // TODO: implement videoEventsFor
    throw UnimplementedError();
  }
}

void main() {
  final JWPlayerPlatform initialPlatform = JWPlayerPlatform.instance;

  test('$MethodChannelJWPlayer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJWPlayer>());
  });

  /// This test only ensures that the current mock is working.
  test('Test Mock creation', () async {
    MockJwplayerPlatform fakePlatform = MockJwplayerPlatform();
    JWPlayerPlatform.instance = fakePlatform;

    expect(await JWVideoPlayer.getPlatformVersion(), '42');
  });

  test('Test configuration parser', () {
    // Given a JSON config.
    dynamic jsonConfig;
    try {
      jsonConfig = TestFile()
          .searchFile("${Directory.current.path}/test/assets/full_config.json")
          .asJSON();
    } catch (e) {
      fail(e.toString());
    }
    // When we try to parse the config.
    JWPlayerConfiguration config =
        JWPlayerConfiguration.fromJson(jsonEncode(jsonConfig));
    // Then assert that the playlist is not empty
    assert(config.playlist!.isNotEmpty);
    // Then assert the sources for the first item is not empty
    assert(config.playlist!.first.sources!.isNotEmpty);
    // Then assert one of the playlist items is not null
    String? file =
        config.playlist?.firstWhere((element) => element.file != null).file;
    assert(file != null);
    assert(config.advertising?.tag != null);
    assert(config.analytics?.client != null);
    assert(config.related?.client != null);
  });

  test('Test player configuraiton', () {
    // Given a JSON config.
    dynamic jsonConfig;
    try {
      jsonConfig = TestFile()
          .searchFile("${Directory.current.path}/test/assets/full_config.json")
          .asJSON();
    } catch (e) {
      fail(e.toString());
    }
    // When we try to parse the config.
    JWPlayerConfiguration config =
        JWPlayerConfiguration.fromJson(jsonEncode(jsonConfig));
    JWVideoPlayer player = JWVideoPlayer(
      config: config,
    );
    assert(player.config == config);
    player
  });
}
