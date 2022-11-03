// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:jwplayer/web/web_player_api/web_player_api.dart';
import 'package:js/js_util.dart' as js;

import '../shims/dart_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../jwplayer_platform_interface.dart';

/// A web implementation of the JwplayerPlatform of the Jwplayer plugin.
class JWPlayerWeb extends JWPlayerPlatform {
  /// Constructs a JwplayerWeb
  JWPlayerWeb();

  // Simulate the native "textureId".
  int _viewCounter = 0;
  final Map<int, html.DivElement> _videoPlayers = <int, html.DivElement>{};

  static void registerWith(Registrar registrar) {
    JWPlayerPlatform.instance = JWPlayerWeb();
  }

  @override
  Future<void> init() async {
    _videoPlayers.forEach((key, value) {
      value.removeAttribute('src');
      value.remove();
      _videoPlayers.remove(key);
    });
  }

  @override
  Future<int> create() async {
    final int _currentView = _viewCounter;

    final html.DivElement div = html.DivElement();
    div.id = "player_$_viewCounter";

    div.setAttribute("style",
        "border: none; display: block; margin: 0; width: 100%; height: 100%;");

    ui.platformViewRegistry
        .registerViewFactory('player_$_currentView', (int viewId) => div);

    _videoPlayers[_viewCounter] = div;

    _viewCounter++;
    return _currentView;
  }

  @override
  Future<void> play(int id) async {
    String playerId = "player_$id";
    PlayerAPI(playerId).play();
  }

  @override
  Future<void> pause(int id) async {
    String playerId = "player_$id";
    PlayerAPI(playerId).pause();
  }

  @override
  Future<void> stop(int id) async {
    String playerId = "player_$id";
    PlayerAPI(playerId).stop();
  }

  @override
  Future<void> setConfig(Map<String, dynamic> config, int id) async {
    String playerId = "player_$id";

    var jsonConfig = mapToJSObj(config);
    PlayerAPI(playerId).setup(jsonConfig);
  }

  @override
  Future<void> setLicenseKey(String licenseKey) async {}

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String> getPlatformVersion() async {
    return playerVersion.substring(0, playerVersion.indexOf("+"));
  }

  @override
  buildView(int viewId, void Function(int) onPlatformViewCreated) {
    return HtmlElementView(
        viewType: 'player_$viewId',
        onPlatformViewCreated: onPlatformViewCreated);
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

Object mapToJSObj(Map<dynamic, dynamic> a) {
  var object = js.newObject();
  a.forEach((k, v) {
    if (v != null) {
      var key = k;
      var value = v;
      js.setProperty(object, key, value);
    }
  });
  return object;
}
