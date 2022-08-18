import 'package:flutter/material.dart';
import 'package:flutter_poc/flutter_poc_platform_interface.dart';

FlutterPocPlatform _lastVideoPlayerPlatform;

FlutterPocPlatform get _videoPlayerPlatform {
  final FlutterPocPlatform currentInstance = FlutterPocPlatform.instance;
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
  const JWVideoPlayer({Key key}) : super(key: key);

  /// The [VideoPlayerController] responsible for the video being rendered in
  /// this widget.

  @override
  State<JWVideoPlayer> createState() => _JWVideoPlayerState();
}

class _JWVideoPlayerState extends State<JWVideoPlayer> {
  int _textureId;

  @override
  void initState() {
    setTextureId();
    super.initState();
  }

  Future<void> setTextureId() async {
    _textureId = await _videoPlayerPlatform.create();
  }

  @override
  Widget build(BuildContext context) {
    return _textureId == null
        ? Center(child: CircularProgressIndicator())
        : _videoPlayerPlatform.buildView(_textureId);
  }
}
