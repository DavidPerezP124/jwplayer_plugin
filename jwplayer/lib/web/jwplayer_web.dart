// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:jwplayer/web/web_player_api/web_player_api.dart' as api;
import 'package:js/js_util.dart' as jsutil;

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

  final Map<String, StreamController<VideoEvent>> _listeners =
      <String, StreamController<VideoEvent>>{};

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
    String playerId = "player_$_viewCounter";
    div.id = playerId;

    div.setAttribute("style",
        "border: none; display: block; margin: 0; width: 100%; height: 100%;");

    ui.platformViewRegistry
        .registerViewFactory('player_$_currentView', (int viewId) => div);
    _videoPlayers[_viewCounter] = div;
    _listeners[playerId] = StreamController<VideoEvent>();
    _viewCounter++;
    return _currentView;
  }

  @override
  Future<void> play(int id) async {
    String playerId = "player_$id";
    api.PlayerAPI(playerId).play();
  }

  @override
  Future<void> pause(int id) async {
    String playerId = "player_$id";
    api.PlayerAPI(playerId).pause();
  }

  @override
  Future<void> stop(int id) async {
    String playerId = "player_$id";
    api.PlayerAPI(playerId).stop();
  }

  @override
  Future<void> setConfig(Map<String, dynamic> config, int id) async {
    String playerId = "player_$id";
    var jsonConfig = mapToJSObj(config);
    api.PlayerAPI(playerId).setup(jsonConfig);
    _addEventListenersFor(playerId);
  }

  void _addEventListenersFor(String playerId) {
    // Listen to the ready event, signaling that the player has loaded the config.
    api.PlayerAPI(playerId).on("ready", js.allowInterop(([a, b]) {
      _listeners[playerId]
          ?.add(VideoEvent(eventType: VideoEventType.initialized));
    }));
    // Listen ton the time updates for the player
    // TODO(davidp): Analyze performance cost of unfiltered time updated.
    api.PlayerAPI(playerId).on("time", js.allowInterop(([a, b]) {
      String event = jsonEncode(jsutil.dartify(a));
      Map<String, dynamic> jsonEvent = jsonDecode(event);
      double position = jsonEvent["position"];
      double duration = jsonEvent["duration"];
      _listeners[playerId]?.add(VideoEvent(
          eventType: VideoEventType.time,
          position: Duration(milliseconds: (position * 1000).round()),
          duration: Duration(milliseconds: (duration * 1000).round())));
    }));
    // Listen to buffer updates
    api.PlayerAPI(playerId).on("bufferChange", js.allowInterop(([a, b]) {
      String event = jsonEncode(jsutil.dartify(a));
      Map<String, dynamic> jsonEvent = jsonDecode(event);
      double percent = jsonEvent["bufferPercent"];
      double position = jsonEvent["position"];
      _listeners[playerId]?.add(VideoEvent(
          eventType: VideoEventType.buffer,
          bufferPercent: percent,
          bufferPosition: position));
    }));
    // Listen to when the player has begun playback
    api.PlayerAPI(playerId).on("play", js.allowInterop(([a, b]) {
      _listeners[playerId]?.add(VideoEvent(
          eventType: VideoEventType.state, state: PlayerState.playing));
    }));
    // Listen to when the player has paused
    api.PlayerAPI(playerId).on("pause", js.allowInterop(([a, b]) {
      _listeners[playerId]?.add(VideoEvent(
          eventType: VideoEventType.state, state: PlayerState.paused));
    }));
    // TODO(davidp): Add more listeners. Analyze performance cost for other listeners.
  }

  @override
  Future<void> setLicenseKey(String licenseKey) async {}

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String> getPlatformVersion() async {
    return api.playerVersion.substring(0, api.playerVersion.indexOf("+"));
  }

  @override
  buildView(int viewId, void Function(int) onPlatformViewCreated) {
    return HtmlElementView(
        viewType: 'player_$viewId',
        onPlatformViewCreated: onPlatformViewCreated);
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    String playerId = 'player_$textureId';
    Stream<VideoEvent> eventListener =
        _listeners[playerId]!.stream.asBroadcastStream();
    return eventListener;
  }

  @override
  Future<void> dispose(int viewId) async {
    _listeners[viewId]?.close();
    _videoPlayers[viewId]?.removeAttribute('src');
    _videoPlayers[viewId]?.remove();
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
  var object = jsutil.newObject();
  a.forEach((k, v) {
    if (v != null) {
      var key = k;
      var value = v;
      jsutil.setProperty(object, key, value);
    }
  });
  return object;
}
