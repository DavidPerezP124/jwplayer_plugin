// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:jwplayer/playerAPI/web_player_api.dart';
import 'package:jwplayer/utils/objectifier.dart';
import 'package:js/js_util.dart' as js;

import 'shims/dart_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'jwplayer_platform_interface.dart';

/// A web implementation of the JwplayerPlatform of the Jwplayer plugin.
class JwplayerWeb extends JwplayerPlatform {
  /// Constructs a JwplayerWeb
  JwplayerWeb();

  // Simulate the native "textureId".
  int _viewCounter = 1;
  final Map<int, html.DivElement> _videoPlayers = <int, html.DivElement>{};

  static void registerWith(Registrar registrar) {
    JwplayerPlatform.instance = JwplayerWeb();
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
    final int _currentView = _viewCounter++;

    final html.DivElement div = html.DivElement();
    div.id = "player_$_currentView";

    div.setAttribute("style",
        "border: none; display: block; margin: 0; width: 100%; height: 100%;");

    ui.platformViewRegistry
        .registerViewFactory('player_$_currentView', (int viewId) => div);

    _videoPlayers[_viewCounter] = div;

    return _currentView;
  }

  @override
  Future<void> setConfig(Map<String, dynamic> config, int id) async {
    print("setting config for player_$id: config: $config");
    var nextId = id + 1;
    String playerId = "player_$nextId";

    var jsonConfig = mapToJSObj(config);

    try {
      PlayerAPI(playerId).setup(jsonConfig);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> setLicenseKey(String licenseKey) async {
    // TODO: implement setLicenseKey
    print(licenseKey);
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
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
