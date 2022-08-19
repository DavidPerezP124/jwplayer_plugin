import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwplayer/jwplayer.dart';
import 'package:jwplayer/jwplayer_configuration.dart';
import 'package:jwplayer_example/getLicense.dart';

JwPlayerConfiguration config1 = JwPlayerConfiguration(
    file:
        "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8");

JwPlayerConfiguration config2 = JwPlayerConfiguration(
    file: "https://content.bitsontherun.com/videos/bkaovAYt-52qL9xLP.mp4",
    image: "https://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg");

JwPlayerConfiguration config3 = JwPlayerConfiguration(
    file:
        "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8");

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

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
      print(e.toString());
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
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Running on: $_platformVersion'),
          ),
          body: Center(
            child: ListView(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: JWVideoPlayer(
                    config: config1,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.2,
                  child: JWVideoPlayer(
                    config: config2,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.2,
                  child: JWVideoPlayer(
                    config: config3,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
