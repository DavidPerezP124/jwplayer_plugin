import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jw_video_player/configuration/jwplayer_configuration.dart';
import 'package:jw_video_player/jwplayer_platform_interface.dart';

JWPlayerPlatform? _lastVideoPlayerPlatform;

JWPlayerPlatform get _videoPlayerPlatform {
  final JWPlayerPlatform currentInstance = JWPlayerPlatform.instance;
  if (_lastVideoPlayerPlatform != currentInstance) {
    // This will clear all open videos on the platform when a full restart is
    // performed.
    currentInstance.init();
    _lastVideoPlayerPlatform = currentInstance;
  }
  return currentInstance;
}

/// The duration, current position, error state and settings
/// of a [JWPlayerController].
class JWVideoPlayerValue {
  /// Constructs a video with the given values.
  JWVideoPlayerValue(
      {this.config,
      this.duration = Duration.zero,
      this.size = Size.zero,
      this.isPlaying = false,
      this.position = Duration.zero,
      this.isInitialized = false,
      this.bufferPercentage = 0.0,
      this.bufferPosition = 0.0,
      this.errorDescription,
      this.state = PlayerState.idle});

  /// Returns an instance for a video that hasn't been loaded.
  JWVideoPlayerValue.uninitialized()
      : this(duration: Duration.zero, isInitialized: false);

  /// Returns an instance with the given [errorDescription].
  JWVideoPlayerValue.erroneous(String errorDescription)
      : this(
            duration: Duration.zero,
            isInitialized: false,
            errorDescription: errorDescription);

  /// The total duration of the video.
  ///
  /// The duration is [Duration.zero] if the video hasn't been initialized.
  final Duration duration;

  JWPlayerConfiguration? config;

  /// The current playback position.
  final Duration position;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is `null`.
  final String? errorDescription;

  /// The [size] of the currently loaded video.
  final Size size;

  /// True if the video is playing. False if it's paused.
  final bool isPlaying;

  /// Indicates whether or not the video has been loaded and is ready to play.
  final bool isInitialized;

  /// Indicates the percentage the content has buffer
  final double bufferPercentage;

  /// Indicates the current position for the buffer regarding the duration
  final double bufferPosition;

  /// Indicates the current state of the player.
  final PlayerState state;

  /// Indicates whether or not the video is in an error state. If this is true
  /// [errorDescription] should have information about the problem.
  bool get hasError => errorDescription != null;

  /// Returns [size.width] / [size.height].
  ///
  /// Will return `1.0` if:
  /// * [isInitialized] is `false`
  /// * [size.width], or [size.height] is equal to `0.0`
  /// * aspect ratio would be less than or equal to `0.0`
  double get aspectRatio {
    if (!isInitialized || size.width == 0 || size.height == 0) {
      return 1.0;
    }
    final double aspectRatio = size.width / size.height;
    if (aspectRatio <= 0) {
      return 1.0;
    }
    return aspectRatio;
  }

  /// Returns a new instance that has the same values as this current instance,
  /// except for any overrides passed in as arguments to [copyWith].
  JWVideoPlayerValue copyWith(
      {Duration? duration,
      Size? size,
      Duration? position,
      bool? isInitialized,
      String? errorDescription,
      double? bufferPercentage,
      double? bufferPosition,
      PlayerState? state}) {
    return JWVideoPlayerValue(
        duration: duration ?? this.duration,
        size: size ?? this.size,
        position: position ?? this.position,
        bufferPercentage: bufferPercentage ?? this.bufferPercentage,
        bufferPosition: bufferPosition ?? this.bufferPosition,
        isInitialized: isInitialized ?? this.isInitialized,
        errorDescription: errorDescription ?? this.errorDescription,
        state: state ?? this.state);
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, 'VideoPlayerValue')}('
        'duration: $duration, '
        'size: $size, '
        'position: $position, '
        'isInitialized: $isInitialized, '
        'errorDescription: $errorDescription)';
  }
}

/// Controls a platform video player, and provides updates when the state is
/// changing.
///
/// Instances must be initialized with initialize.
///
/// The video is displayed in a Flutter app by creating a [VideoPlayer] widget.
///
/// To reclaim the resources used by the player call [dispose].
///
/// After [dispose] all further calls are ignored.
class JWPlayerController extends ValueNotifier<JWVideoPlayerValue> {
  JWPlayerController({JWVideoPlayerValue? value})
      : super(value ?? JWVideoPlayerValue.uninitialized());

  bool _isDisposed = false;
  Completer<void>? _creatingCompleter;
  StreamSubscription<dynamic>? _eventSubscription;
  _JWVideoAppLifeCycleObserver? _lifeCycleObserver;

  @visibleForTesting
  static const int kUninitializedTextureId = -1;
  int _textureId = kUninitializedTextureId;

  int get textureId => _textureId;

  /// Starts playing the content.
  ///
  /// If the video is at the end, this method starts playing from the beginning.
  ///
  /// This method returns a future that completes as soon as the "play" command
  /// has been sent to the platform, not when playback has started.
  Future<void> play() async {
    await _videoPlayerPlatform.play(textureId);
  }

  static Future<String?> getPlatformVersion() async {
    return await _videoPlayerPlatform.getPlatformVersion();
  }

  Future<void> setConfig(Map<String, dynamic> config, int id) async {
    await _videoPlayerPlatform.setConfig(config, id);
  }

  static Future<void> setLicenseKey(String licence) async {
    await _videoPlayerPlatform.setLicenseKey(licence);
  }

  Widget buildView(int texture, void Function(int) onPlatformViewCreated) {
    return _videoPlayerPlatform.buildView(texture, onPlatformViewCreated);
  }

  /// Pauses the content.
  ///
  /// This method returns a future that completes as soon as the "pause" command
  /// has been sent to the platform, not when playback has paused.
  Future<void> pause() async {
    await _videoPlayerPlatform.pause(textureId);
  }

  /// Stops the content.
  ///
  /// This finishes the current video, and enters an idle state.
  ///
  /// This method returns a future that completes as soon as the "stop" command
  /// has been sent to the platform, not when the player has stopped its content.
  Future<void> stop() async {
    await _videoPlayerPlatform.stop(textureId);
  }

  /// Seeks into the content.
  ///
  /// This finishes the current video, and enters an idle state.
  ///
  /// This method returns a future that completes as soon as the "stop" command
  /// has been sent to the platform, not when the player has stopped its content.
  Future<void> seek(double to) async {
    await _videoPlayerPlatform.seek(to, textureId);
  }

  Future<int> initialize() async {
    _lifeCycleObserver?.initialize();
    _textureId = await _videoPlayerPlatform.create();
    setupListeners(_textureId);
    return _textureId;
  }

  void setupListeners(int id) {
    void errorListener(Object obj) {
      final JWPlatformException e = obj as JWPlatformException;
      value = JWVideoPlayerValue.erroneous(e.message!);
    }

    _eventSubscription = _videoPlayerPlatform
        .videoEventsFor(_textureId)
        .listen(_eventListener, onError: errorListener);
  }

  void _eventListener(VideoEvent event) {
    if (_isDisposed) {
      return;
    }

    switch (event.eventType) {
      case VideoEventType.initialized:
        value = value.copyWith(
          isInitialized: true,
          errorDescription: null,
        );
        break;
      case VideoEventType.completed:
        break;
      case VideoEventType.time:
        value = value.copyWith(
          position: event.position,
          duration: event.duration,
          errorDescription: null,
        );
        break;
      case VideoEventType.unknown:
        break;
      case VideoEventType.buffer:
        value = value.copyWith(
          bufferPercentage: event.bufferPercent,
          bufferPosition: event.bufferPosition,
        );
        break;
      case VideoEventType.state:
        value = value.copyWith(
          state: event.state,
        );
        break;
    }
  }

  @override
  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }

    if (_creatingCompleter != null) {
      await _creatingCompleter!.future;
      if (!_isDisposed) {
        _isDisposed = true;
        await _eventSubscription?.cancel();
        await _videoPlayerPlatform.dispose(_textureId);
      }
      _lifeCycleObserver?.dispose();
    }
    _isDisposed = true;
    super.dispose();
  }
}

class _JWVideoAppLifeCycleObserver extends Object with WidgetsBindingObserver {
  _JWVideoAppLifeCycleObserver(this._controller);

  bool _wasPlayingBeforePause = false;
  final JWPlayerController _controller;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _wasPlayingBeforePause = _controller.value.isPlaying;
        _controller.pause();
        break;
      case AppLifecycleState.resumed:
        if (_wasPlayingBeforePause) {
          _controller.play();
        }
        break;
      default:
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
