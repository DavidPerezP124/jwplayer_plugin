import 'package:flutter/material.dart';
import 'package:jw_video_player/jwplayer.dart';

import '../models/video_info.dart';
import '../utils/license_util.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.video});

  final VideoInfo video;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState(video);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  _VideoPlayerScreenState(this.video);

  final VideoInfo video;

  @override
  void initState() {
    try {
      JWVideoPlayer.setLicenseKey(GetLicense.getLicense());
    } catch (e) {
      debugPrint(e.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      // Use the VideoPlayer widget to display the video.
      child: JWVideoPlayer(
        config: JWPlayerConfiguration(file: video.sources.first.file),
      ),
    );
  }
}
