// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_poc_platform_interface.dart';

/// A web implementation of the FlutterPocPlatform of the FlutterPoc plugin.
class FlutterPocWeb extends FlutterPocPlatform {
  /// Constructs a FlutterPocWeb
  FlutterPocWeb();
  // Simulate the native "textureId".
  int _viewCounter = 1;
  final Map<int, html.IFrameElement> _videoPlayers =
      <int, html.IFrameElement>{};

  static void registerWith(Registrar registrar) {
    FlutterPocPlatform.instance = FlutterPocWeb();
  }

  @override
  Future<void> init() {
    _videoPlayers.forEach((key, value) {
      value.removeAttribute('src');
      value.remove();
      _videoPlayers.remove(key);
    });
  }

  @override
  Future<int> create() async {
    final int _currentView = _viewCounter++;

    final html.IFrameElement div = html.IFrameElement();

    div.src = "https://cdn.jwplayer.com/players/1x2AZ55n-4SploSrk.html";
    div.onLoad.listen((_) {
      print('onLoad');
    });
    div.onLoadedData.listen((data) {
      print('onLoadedData $data');
    });
    ui.platformViewRegistry
        .registerViewFactory('player_$_currentView', (int viewId) => div);

    _videoPlayers[_viewCounter] = div;

    return _currentView;
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

  @override
  buildView(int viewId) {
    return HtmlElementView(viewType: 'player_$viewId');
  }
}

class AllowAll implements html.NodeValidator {
  @override
  bool allowsAttribute(
      html.Element element, String attributeName, String value) {
    return true;
  }

  @override
  bool allowsElement(html.Element element) {
    return true;
  }
}
