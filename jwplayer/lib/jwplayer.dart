import 'package:flutter/material.dart';
import 'package:jwplayer/jwplayer_configuration.dart';

import 'jwplayer_platform_interface.dart';

JwplayerPlatform? _lastVideoPlayerPlatform;

JwplayerPlatform get _videoPlayerPlatform {
  final JwplayerPlatform currentInstance = JwplayerPlatform.instance;
  if (_lastVideoPlayerPlatform != currentInstance) {
    // This will clear all open videos on the platform when a full restart is
    // performed.
    currentInstance.init();
    _lastVideoPlayerPlatform = currentInstance;
  }
  return currentInstance;
}

class JWVideoPlayer extends StatefulWidget {
  /// Uses the given [controller] for all video rendered in this widget.
  const JWVideoPlayer({Key? key, this.config}) : super(key: key);
  final JwPlayerConfiguration? config;

  /// The [VideoPlayerController] responsible for the video being rendered in
  /// this widget.

  @override
  State<JWVideoPlayer> createState() => _JWVideoPlayerState();

  static Future<String?> getPlatformVersion() =>
      _videoPlayerPlatform.getPlatformVersion();

  static Future<void> setLicenseKey(String licenseKey) =>
      _videoPlayerPlatform.setLicenseKey(licenseKey);
}

class _JWVideoPlayerState extends State<JWVideoPlayer> {
  int? _textureId;

  @override
  void initState() {
    super.initState();
    setTextureId();
  }

  Future<void> setTextureId() async {
    final id = await _videoPlayerPlatform.create();
    setState(() {
      _textureId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _textureId == null
        ? const Center(child: CircularProgressIndicator())
        : _videoPlayerPlatform.buildView(_textureId!, setConfig);
  }

  Future<void> setConfig(int id) async {
    if (widget.config == null) return;
    await _videoPlayerPlatform.setConfig(widget.config!.toJson(), id);
  }
}
