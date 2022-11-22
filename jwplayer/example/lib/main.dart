import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jw_video_player/jwplayer.dart';
import 'package:jw_video_player_example/get_license.dart';

JWPlayerConfiguration config1 = JWPlayerConfiguration(
    file:
        "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8");

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Title',
      home: PlayerApp(),
    );
  }
}

class PlayerApp extends StatefulWidget {
  const PlayerApp({Key? key}) : super(key: key);

  @override
  State<PlayerApp> createState() => _PlayerAppState();
}

class _PlayerAppState extends State<PlayerApp> {
  String _platformVersion = 'Unknown';
  final JWPlayerController _controller = JWPlayerController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      JWVideoPlayer.setLicenseKey(GetLicense.getLicense());
    } catch (e) {
      debugPrint(e.toString());
    }
    try {
      platformVersion = await JWVideoPlayer.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Player version: $_platformVersion'),
        ),
        body: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ConstrainedBox(
              // If the app aspect ratio is W:h limit width to 70%, if w:H use the total width.
              constraints: BoxConstraints(
                  maxWidth: height > width ? width : width * 0.7),
              child: AspectRatio(
                aspectRatio: 2.1,
                child: JWVideoPlayer(
                  config: config1,
                  controller: _controller,
                ),
              ),
            ),
            PlayerStatusView(controller: _controller),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: _controller.play,
                  icon: const Icon(Icons.play_arrow)),
              IconButton(
                  onPressed: _controller.pause, icon: const Icon(Icons.pause)),
              IconButton(
                  onPressed: _controller.stop, icon: const Icon(Icons.stop))
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerStatusView extends StatelessWidget {
  const PlayerStatusView({
    Key? key,
    required JWPlayerController controller,
  })  : _controller = controller,
        super(key: key);

  final JWPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: ((context, JWVideoPlayerValue value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Player Controller Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("position: ${value.position.toString()}"),
              const Padding(padding: EdgeInsets.all(2)),
              Text("duration: ${value.duration.toString()}"),
              const Padding(padding: EdgeInsets.all(2)),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("buffered: "),
                  CircularProgressIndicator(
                    value: (value.bufferPercentage / 100),
                    backgroundColor: Colors.transparent,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  const Text("state: "),
                  Icon(value.state == PlayerState.playing
                      ? Icons.play_circle
                      : Icons.pause_circle)
                ],
              ),
            ],
          )),
    );
  }
}
